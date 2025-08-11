//
//  LevelDetailView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/8.
//

import SwiftUI
import SwiftData

struct LevelDetailView: View {
//    let levelParams: LevelDetailParams
    @Bindable var courseViewModel: CourseViewModel
    @Binding var path: NavigationPath
    
    @State private var isLoading = true
    @State private var error: String? = nil
    // Load from DB based on passed in CourseSession and ExerciseLevel
    @State private var levelProgress: LevelProgress? = nil
    @State private var exercises: [ExerciseV2] = []
    // Collect each ExerciseProgress to show summary.
    // Passed from child view after an ExerciseProgress
    // is created or loaded from DB
    @State private var exerciseStates: [String: ExerciseProgress] = [:]
    
    // Current tab
    @State private var selectedIndex = 0
    @State var showSummary = false
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var currentLevel: ExerciseLevel? {
        courseViewModel.currentLevel
    }
    
    func resetState() {
        isLoading = true
        selectedIndex = 0
        error = nil
        levelProgress = nil
        exerciseStates = [:]
    }
    
    private var progressText: String {
        "\(selectedIndex + 1) / \(self.exercises.count)"
    }
    
    private var isLast: Bool {
        selectedIndex == self.exercises.count - 1
    }
    
    private var score: Int {
        exercises.reduce(0) { total, ex in
            if exerciseStates[ex.id]?.isCorrect == true {
                return total + 1
            } else {
                return total
            }
        }
    }
    
    private var allAnswered: Bool {
        // returns true if and only if every element of the sequence satisfies the given predicate. In this case,
        // the predicate is checking if the element's ID exists as a key in your dictionary.
        exercises.allSatisfy { item in
            exerciseStates.keys.contains(item.id)
        }
    }
    
    var hasNextLevel: Bool {
        courseViewModel.hasNextLevel
    }
    
    var allLevelsComplete: Bool {
        courseViewModel.allLevelsComplete
    }
    
    var body: some View {
        VStack {
            if self.isLoading {
                ProgressView()
            } else if let levelProgress = self.levelProgress, let level = currentLevel {
                let totalCount = self.exercises.count
                
                HStack {
                    Text("\(self.progressText)")
                }
                Button("Next") {
                    goToNextLevel()
                }
                TabView(selection: $selectedIndex) {
                    ForEach(self.exercises.indices, id: \.self) { index in
                        
                        MultipleChoiceView(
                            level: level,
                            levelProgress: levelProgress,
                            exercise: self.exercises[index],
                            isLast: index == totalCount - 1,
                            showSummary: $showSummary,
                            onAnswer: self.saveExerciseProgress,
                            onLevelComplete: self.markLevelComplete,
                        )
                        .tag(index)
                    }
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .indexViewStyle(.page(backgroundDisplayMode: .never))
                
                
            } else if let error = self.error {
                Text(error)
            }
        }
        .navigationTitle(courseViewModel.navTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Label("Back", systemImage: "xmark")
                }
                
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("下一题") {
                    self.advance()
                }
                .disabled(isLast)
            }
        }
        .sheet(isPresented: $showSummary) {
            LevelSummarySheet(
                levelProgress: self.levelProgress,
                hasNextLevel: self.hasNextLevel,
                allLevelsComplete: self.allLevelsComplete,
                onRestart: self.restart,
                onNextLevel: self.goToNextLevel,
                onFinish: self.endOfLevels,
            )
        }
        .task {
            await loadLevelAndExercises()
            await courseViewModel.updateSession(context: modelContext)
        }
    }
    
    private func advance() {
        print("Current index \(selectedIndex)")
        
        if selectedIndex < self.exercises.count - 1 {
            selectedIndex += 1
            print("Progressed to \(selectedIndex)")
        }
    }
    
    private func restart() {
        resetState()
        
        Task {
            await loadLevelAndExercises()
        }
    }
    
    func goToNextLevel() {
        print("Go to next level")
        resetState()
        
        courseViewModel.moveToNextLevel()
        
        Task {
            await loadLevelAndExercises()
        }
    }
    
    func endOfLevels() {
        if !path.isEmpty {
            // Simply remove or append to path is safe.
            path.removeLast()
        }
    }
    
    // Callback when exercise progress is updated.
    @MainActor
    func saveExerciseProgress(exerciseProgress: ExerciseProgress) {
        self.exerciseStates[exerciseProgress.exerciseID] = exerciseProgress
        print("exercise progress count: \(self.exerciseStates.count)")
        
        self.levelProgress?.moveExercise(
            lastIndex: self.selectedIndex,
            score: self.score
        )
        
        if let levelProgress {
            Task {
                await updateLevelProgress(levelProgress: levelProgress)
            }
        }
    }
    
    // Callback when clicked show summary button.
    @MainActor
    func markLevelComplete() {
        print("Mark level complete")
        let levelComplete = self.allAnswered
        
        self.levelProgress?.moveExercise(
            lastIndex: self.selectedIndex,
            score: self.score,
            finished: levelComplete,
        )
        
        if let levelProgress {
            if levelComplete {
                courseViewModel.markLevelComplete(levelProgress: levelProgress)
            }
            
            Task {
                await updateLevelProgress(levelProgress: levelProgress)
            }
        }
        
    }
    
    @MainActor
    private func updateLevelProgress(levelProgress: LevelProgress) async {
        do {
            try await SessionDataSource.shared
                .updateLevelProgress(
                    for: levelProgress,
                    context: modelContext
                )
        } catch {
            print("Error updating level progress: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    private func loadLevelAndExercises() async {
        isLoading = true
        guard let session = courseViewModel.session else {
            isLoading = false
            self.error = "Course session not loaded"
            return
        }
        
        guard let level = currentLevel else {
            isLoading = false
            self.error = "No exercise level found"
            return
        }
        
        
        do {
            let exercises = await ExerciseDataSource.shared.loadExercises(
                for: courseViewModel.course,
                level: level
            )
            
            let levelProgress = try await SessionDataSource.shared.loadOrCreateLevelProgress(
                for: level,
                exerciseCount: exercises.count,
                of: session,
                context: self.modelContext
            )
            
            let exerciseProgressPairs = levelProgress.exerciseProgress.map{
                ($0.exerciseID, $0)
            }
            let existingExerciseStates = Dictionary(
                exerciseProgressPairs,
                uniquingKeysWith: { (first, _) in first }
            )
            
            self.levelProgress = levelProgress
            self.exercises = exercises
            self.exerciseStates = existingExerciseStates
            
            print("LevelDetailView: \(levelProgress.levelID)")
            print("LevelDetailView: exercises count \(exercises.count)")
            print("LevelDetailView: existing exercise state \(exerciseStates)")
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}

#Preview {
    @Previewable @State var courseViewModel = CourseViewModel.mock(course: Course.all[0])
    @Previewable @State var path = NavigationPath()
    
    NavigationStack(path: $path) {
        LevelDetailView(
            courseViewModel: courseViewModel,
            path: $path,
        )
    }
    .modelContainer(for: [CourseSessionEntity.self], inMemory: true)
}
