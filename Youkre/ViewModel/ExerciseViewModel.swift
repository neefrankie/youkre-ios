//
//  ExerciseViewModel.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/9/15.
//

import SwiftUI
import SwiftData

@Observable
class ExerciseViewModel {
    var isLoading = true
    var error: String? = nil
    var exerciseProgress: ExerciseProgress? = nil
    
    var selectedIndex: Int? {
        exerciseProgress?.selectedIndex
    }
    
    func loadData(
        for exercise: Exercise,
        of levelProgress: LevelProgress,
        exerciseProgress: ExerciseProgress?,
    ) {
        if exerciseProgress != nil {
            print("Use cached exercise prgress.")
            self.exerciseProgress = exerciseProgress
            isLoading = false
            return
        }
        
        isLoading = true
        
        Task(priority: .background) {
            do {
                let backgroundContext = ModelContext(DataController.shared)
                
                let progress = try await SessionDataSource.shared.createExerciseProgress(
                    context: backgroundContext,
                    for: exercise,
                    ofLevel: levelProgress
                )
                
                print("Exercise progress: \(progress)")
                await MainActor.run {
                    self.exerciseProgress = progress
                    self.isLoading = false
                }
            } catch {
                print(error)
                await handleLoadFailure(error.localizedDescription)
            }
        }
    }
    
    private func handleLoadFailure(_ message: String) async {
        await MainActor.run {
            self.error = message
            self.isLoading = false
        }
    }
    
    func checkAnswer(selected: Int, exercise: Exercise) -> ExerciseProgress {
        print("Selected \(selected)")
        
        guard var progress = exerciseProgress else {
            // Fallback to a new ExerciseProgress instance.
            // This usually won't happen.
            let newProgress = ExerciseProgress.new(exerciseID: exercise.id)
            self.exerciseProgress = newProgress
            return newProgress
        }
        
        // Only allow answer once
        guard !progress.isCompleted else {
            return progress
        }
        
        progress.answered(
            correct: selected == exercise.multipleChoice.correctIndex,
            selectedIndex: selected,
        )
        
        print("Exercise answered: \(progress)")
        
        self.exerciseProgress = progress
        
        Task(priority: .background) {
            do {
                print("Update exercise progress to db")
                let backgroundContext = ModelContext(DataController.shared)
                
                try await SessionDataSource.shared.updateExerciseProgress(
                    context: backgroundContext,
                    from: progress,
                )
            } catch {
                print("Error updating exercise progress: \(error.localizedDescription)")
            }
        }
        
        return progress
    }
}
