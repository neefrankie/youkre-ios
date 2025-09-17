//
//  LevelDetailViewModel.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/26.
//

import SwiftUI
import SwiftData

@Observable
class LevelViewModel {
    var isLoading = true
    var error: String? = nil
    var levelProgress: LevelProgress? = nil
    var exercises: [Exercise] = []
    private var exerciseStates: [String: ExerciseProgress] = [:]
    
    // Current tab
    var selectedTabIndex = 0
    
    var isLast: Bool {
        selectedTabIndex == self.exercises.count - 1
    }
    
    var progressText: String {
        "\(selectedTabIndex + 1) / \(self.exercises.count)"
    }
    
    var currentExercise: Exercise? {
        if selectedTabIndex >= self.exercises.count {
            return nil
        }
        
        return self.exercises[selectedTabIndex]
    }
    
    var score: Int {
        exercises.reduce(0) { total, ex in
            if exerciseStates[ex.id]?.isCorrect == true {
                return total + 1
            } else {
                return total
            }
        }
    }
    
    var allAnswered: Bool {
        // returns true if and only if every element of the sequence satisfies the given predicate. In this case,
        // the predicate is checking if the element's ID exists as a key in your dictionary.
        exercises.allSatisfy { item in
            exerciseStates.keys.contains(item.id)
        }
    }
    
    func advance() {
        print("Current index \(selectedTabIndex)")
        
        if selectedTabIndex < self.exercises.count - 1 {
            selectedTabIndex += 1
            print("Progressed to \(selectedTabIndex)")
        }
    }
    
    func resetState() {
        isLoading = true
        error = nil
        selectedTabIndex = 0
        levelProgress = nil
        exerciseStates = [:]
    }
    
    func loadData(
        course: Course,
        session: CourseSession?,
        level: ExerciseLevel?
    ) {
        isLoading = true
        
        Task(priority: .background) {
            guard let session else {
                await handleLoadFailure("Course session not loaded")
                return
            }
            
            guard let level else {
                await handleLoadFailure("No exercise level found")
                return
            }
            
            do {
                // Retrieve data from SQLite
                let exercises = try await ExerciseDataSource.shared.loadExercises(
                    for: course,
                    level: level
                )
                
                let backgroundContext = ModelContext(DataController.shared)
                
                // Retrieve data from SwiftData
                let levelProgress = try await SessionDataSource.shared.loadOrCreateLevelProgress(
                    for: level,
                    exerciseCount: exercises.count,
                    of: session,
                    context: backgroundContext
                )
                
                let exerciseProgressPairs = levelProgress.exerciseProgress.map{
                    ($0.exerciseID, $0)
                }
                let existingExerciseStates: [String: ExerciseProgress] = Dictionary(
                    exerciseProgressPairs,
                    uniquingKeysWith: { (first, _) in first }
                )
                
                await MainActor.run {
                    self.levelProgress = levelProgress
                    self.exercises = exercises
                    self.exerciseStates = existingExerciseStates
                    self.isLoading = true
                }
                
            } catch {
                await handleLoadFailure(error.localizedDescription)
            }
            
        }
    }
    
    // ✅ 提取失败处理，确保在主线程更新 UI
    private func handleLoadFailure(_ message: String) async {
        await MainActor.run {
            self.error = message
            self.isLoading = false
        }
    }
    
    func updateLevelProgress(
        dueTo exerciseProgress: ExerciseProgress,
        modelContext: ModelContext
    ) {
        self.exerciseStates[exerciseProgress.exerciseID] = exerciseProgress
        
        tryCompleteLevel(modelContext: modelContext)
    }
    
    func tryCompleteLevel(
        modelContext: ModelContext
    ) {
        print("Mark level complete")
        let levelComplete = self.allAnswered
        
        self.levelProgress?.moveExercise(
            lastIndex: self.selectedTabIndex,
            score: self.score,
            finished: levelComplete,
        )
        
        if let levelProgress {
            Task(priority: .background) {
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
        }
        
    }
}
