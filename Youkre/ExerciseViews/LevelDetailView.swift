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
    
    @State private var viewModel = LevelDetailViewModel()
    
    @State var showSummary = false
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let levelProgress = viewModel.levelProgress, let level = courseViewModel.currentLevel {
                
                HStack {
                    Text("\(viewModel.progressText)")
                }
                
                TabView(selection: $viewModel.selectedTabIndex) {
                    ForEach(viewModel.exercises.indices, id: \.self) { index in
                        
                        MultipleChoiceView(
                            level: level,
                            levelProgress: levelProgress,
                            exercise: viewModel.exercises[index],
                            isLast: viewModel.isLast,
                            showSummary: $showSummary,
                            onAnswer: self.saveExerciseProgress,
                            onLevelComplete: self.markLevelComplete,
                        )
                        .tag(index)
                    }
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .indexViewStyle(.page(backgroundDisplayMode: .never))
                
                
            } else if let error = viewModel.error {
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
                    viewModel.advance()
                }
                .disabled(viewModel.isLast)
            }
            ToolbarItem(placement: .bottomBar) {
                if let level = courseViewModel.currentLevel, let exercise = viewModel.currentExercise {
                    ExerciseBottomBar(
                        level: level,
                        exercise: exercise
                    )
                }
            }
        }
        .sheet(isPresented: $showSummary) {
            LevelSummarySheet(
                levelProgress: viewModel.levelProgress,
                hasNextLevel: courseViewModel.hasNextLevel,
                allLevelsComplete: courseViewModel.allLevelsComplete,
                onRestart: self.onRestart,
                onNextLevel: self.onNextLevel,
                onFinish: self.onFinish,
            )
        }
        
        .task {
            loadLevelAndExercises()
            await courseViewModel.updateSession(context: modelContext)
        }
    }
    
    private func loadLevelAndExercises() {
        Task {
            await viewModel.loadLevelAndExercises(
                modelContext: modelContext,
                course: courseViewModel.course,
                session: courseViewModel.session,
                level: courseViewModel.currentLevel
            )
        }
    }
    
    // Callback
    private func onRestart() {
        viewModel.resetState()
        showSummary = false
        
        loadLevelAndExercises()
    }
    
    // Callback
    func onNextLevel() {
        print("Go to next level")
        viewModel.resetState()
        showSummary = false
        
        courseViewModel.moveToNextLevel()
        
        loadLevelAndExercises()
    }
    
    // Callback
    func onFinish() {
        if !path.isEmpty {
            // Simply remove or append to path is safe.
            path.removeLast()
        }
    }
    
    // Callback when exercise progress is updated.
    @MainActor
    func saveExerciseProgress(exerciseProgress: ExerciseProgress) {
        Task {
            await viewModel.saveExerciseProgress(
                modelContext: modelContext,
                exerciseProgress: exerciseProgress,
            )
        }
    }
    
    // When the Finish button is clicked for the last exercise.
    @MainActor
    func markLevelComplete() {
        Task {
            await viewModel.markLevelComplete(modelContext: modelContext)
        }
        
        if let levelProgress = viewModel.levelProgress, viewModel.allAnswered {
            // Only update level progress when all exercises are answered.
            courseViewModel.markLevelComplete(
                levelProgress: levelProgress
            )
        }
        
    }
    
    
}

#Preview {
    @Previewable @StateObject var themeManager = ThemeManager.shared
    @Previewable @State var courseViewModel = CourseViewModel.mock(course: ExampleData.courses[0])
    @Previewable @State var path = NavigationPath()
    
    NavigationStack(path: $path) {
        LevelDetailView(
            courseViewModel: courseViewModel,
            path: $path,
        )
        .navigationDestination(for: ChapterLink.self) { params in
            ChapterView(params: params)
        }
    }
    .environmentObject(themeManager)
    .preferredColorScheme(themeManager.preferredColorScheme)
    .modelContainer(for: [CourseSessionEntity.self], inMemory: true)
}
