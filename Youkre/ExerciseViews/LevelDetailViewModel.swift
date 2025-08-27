//
//  LevelDetailViewModel.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/26.
//

import SwiftUI
import SwiftData

@Observable
class LevelDetailViewModel {
    var isLoading = true
    var error: String? = nil
    var levelProgress: LevelProgress? = nil
    var exercises: [ExerciseV2] = []
    private var exerciseStates: [String: ExerciseProgress] = [:]
    
    // Current tab
    var selectedTabIndex = 0
    
    var isLast: Bool {
        selectedTabIndex == self.exercises.count - 1
    }
    
    var progressText: String {
        "\(selectedTabIndex + 1) / \(self.exercises.count)"
    }
    
    var currentExercise: ExerciseV2? {
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
    
    @MainActor
    func loadLevelAndExercises(
        modelContext: ModelContext,
        course: Course,
        session: CourseSession?,
        level: ExerciseLevel?
    ) async {
        isLoading = true
        guard let session else {
            isLoading = false
            self.error = "Course session not loaded"
            return
        }
        
        guard let level else {
            isLoading = false
            self.error = "No exercise level found"
            return
        }
        
        
        do {
            let exercises = try await ExerciseDataSource.shared.loadExercises(
                for: course,
                level: level
            )
            
            let levelProgress = try await SessionDataSource.shared.loadOrCreateLevelProgress(
                for: level,
                exerciseCount: exercises.count,
                of: session,
                context: modelContext
            )
            
            let exerciseProgressPairs = levelProgress.exerciseProgress.map{
                ($0.exerciseID, $0)
            }
            let existingExerciseStates: [String: ExerciseProgress] = Dictionary(
                exerciseProgressPairs,
                uniquingKeysWith: { (first, _) in first }
            )
            
            self.levelProgress = levelProgress
            self.exercises = exercises
            self.exerciseStates = existingExerciseStates
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    // When a choice is clicked for an exercise.
    @MainActor
    func saveExerciseProgress(
        modelContext: ModelContext,
        exerciseProgress: ExerciseProgress,
    ) async {
        self.exerciseStates[exerciseProgress.exerciseID] = exerciseProgress
        
        self.levelProgress?.moveExercise(
            lastIndex: selectedTabIndex,
            score: self.score
        )
        
        if let levelProgress {
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
    
    @MainActor
    func markLevelComplete(
        modelContext: ModelContext
    ) async {
        print("Mark level complete")
        let levelComplete = self.allAnswered
        
        self.levelProgress?.moveExercise(
            lastIndex: self.selectedTabIndex,
            score: self.score,
            finished: levelComplete,
        )
        
        if let levelProgress {
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
