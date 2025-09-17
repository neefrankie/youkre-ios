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
    // Key is ExerciseProgress.exerciseID
    private var exerciseStates: [String: ExerciseProgress] = [:]
    
    // Current tab
    var selectedTabIndex = 0
    
    var showSummary = false
    
    
    var isLast: Bool {
        selectedTabIndex == self.exercises.count - 1
    }
    
    var lastAnswered: Bool {
        if let id = exercises.last?.id, let p = exerciseStates[id] {
            return p.isCompleted
        }
        
        return false
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
    
    func onSummary() {
        showSummary = true
    }
    
    // Try to use a cached one to avoid query db frequently.
    func getExerciseProgress(exerciseID: String) -> ExerciseProgress? {
        return exerciseStates[exerciseID]
    }
    
    func advance() {
        print("Current index \(selectedTabIndex)")
        
        if selectedTabIndex < self.exercises.count - 1 {
            selectedTabIndex += 1
            print("Progressed to \(selectedTabIndex)")
        }
    }
    
    func setLevelComplete() {
        levelProgress?.markComplete()
    }
    
    func resetState() {
        isLoading = true
        error = nil
        selectedTabIndex = 0
        levelProgress = nil
        exerciseStates = [:]
        showSummary = false
    }
    
    func loadData(
        for level: ExerciseLevel?,
        of session: CourseSession?,
        course: Course,
    ) {
        Task(priority: .background) {
            let backgroundContext = ModelContext(DataController.shared)
            
            await loadDataAsync(
                modelContext: backgroundContext,
                for: level,
                of: session,
                course: course
            )
        }
    }
    
    private func loadDataAsync(
        modelContext: ModelContext,
        for level: ExerciseLevel?,
        of session: CourseSession?,
        course: Course,
    ) async {
        
        await handleLoadStarted()
        
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
            
            // Retrieve data from SwiftData
            let (levelProgress, exerciseProgressList) = try await SessionDataSource.shared.loadOrCreateLevelProgress(
                context: modelContext,
                for: level,
                ofCourse: session,
                exerciseCount: exercises.count,
            )
            
            let exerciseProgressPairs = exerciseProgressList.map{
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
                self.isLoading = false
            }
        } catch {
            await handleLoadFailure(error.localizedDescription)
        }
    }
    
    private func restartAsync(
        modelContext: ModelContext,
        for level: ExerciseLevel?,
        of session: CourseSession?,
        course: Course,
    ) async {
        await handleLoadStarted()
        
        guard let session else {
            await handleLoadFailure("Course session not loaded")
            return
        }
        
        guard let level else {
            await handleLoadFailure("No exercise level found")
            return
        }
        
        do {
            
            // Retrieve data from SwiftData
            let levelProgress = try await SessionDataSource.shared.createLevelProgres(
                context: modelContext,
                for: level,
                ofCourse: session,
                exerciseCount: exercises.count,
            )
            
            await MainActor.run {
                self.levelProgress = levelProgress
                self.isLoading = false
            }
        } catch {
            await handleLoadFailure(error.localizedDescription)
        }
    }
    
    private func handleLoadFailure(_ message: String) async {
        await MainActor.run {
            self.error = message
            self.isLoading = false
        }
    }
    
    private func handleLoadStarted() async {
        await MainActor.run {
            self.isLoading = true
            self.error = nil
        }
    }
    
    private func updateProgressAsync(
        modelContext: ModelContext,
        progress: LevelProgress
    ) async {
        do {
            try await SessionDataSource.shared.updateLevelProgress(
                context: modelContext,
                from: progress,
            )
        } catch {
            print("Error updating level progress: \(error.localizedDescription)")
        }
    }
    
    // update level progres is executed every time an exercise is answered.
    func updateLevelProgress(
        dueTo exerciseProgress: ExerciseProgress,
    ) {
        print("Update level progress due to exercise progress")
        self.exerciseStates[exerciseProgress.exerciseID] = exerciseProgress
        
        self.levelProgress?.moveExercise(
            lastIndex: self.selectedTabIndex,
            score: self.score,
        )
        
        if let levelProgress {
            Task(priority: .background) {
                let backgroundContext = ModelContext(DataController.shared)
                await updateProgressAsync(modelContext: backgroundContext, progress: levelProgress)
            }
        }
    }
    
    // Start a new level or restart current one, depending on
    // the value inf course session.
    func restartCurrentLevel(
        for level: ExerciseLevel?,
        of session: CourseSession?,
        course: Course,
    ) -> LevelProgress? {
        // Mark current level as completed.
        setLevelComplete()
        
        let currentLevelProgress = levelProgress
        
        // Returns immediately.
        Task(priority: .background) {
            let backgroundContext = ModelContext(DataController.shared)
            
            // Save level progress before resetting to nil.
            if let currentLevelProgress {
                await updateProgressAsync(
                    modelContext: backgroundContext,
                    progress: currentLevelProgress,
                )
            }
            
            await MainActor.run {
                resetState()
            }
            
            await restartAsync(
                modelContext: backgroundContext,
                for: level,
                of: session,
                course: course,
            )
        }
        
        return currentLevelProgress
    }
    
    
    func startNewLevel(
        for level: ExerciseLevel?,
        of session: CourseSession?,
        course: Course,
    ) -> LevelProgress? {
        // Mark current level as completed.
        setLevelComplete()
        
        let currentLevelProgress = levelProgress
        
        // Returns immediately.
        Task(priority: .background) {
            let backgroundContext = ModelContext(DataController.shared)
            
            // Save level progress before resetting to nil.
            if let currentLevelProgress {
                await updateProgressAsync(
                    modelContext: backgroundContext,
                    progress: currentLevelProgress,
                )
            }
            
            await MainActor.run {
                resetState()
            }
            
            await loadDataAsync(
                modelContext: backgroundContext,
                for: level,
                of: session,
                course: course,
            )
        }
        
        return currentLevelProgress
    }
    
}
