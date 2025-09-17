//
//  CourseViewModel.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/10.
//

import SwiftUI
import SwiftData

@Observable
class CourseViewModel {
    let course: Course
    
    init(course: Course) {
        self.course = course
    }
    
    var isLoading = true
    var error: String? = nil
    
    var levels: [ExerciseLevel] = []
    // Data from DB
    var session: CourseSession?
    
    // Used to indicate whether user has ever completed a level.
    var levelsCompleted: [String: Bool] = [:]
    
    var currentLevel: ExerciseLevel? {

        if let index = session?.lastLevelIndex, index < levels.count {
            return levels[index]
        }
        
        print("Unable to get current level")
        return nil
    }
    
    var allLevelsComplete: Bool {
        levels.allSatisfy { l in
            levelsCompleted.keys.contains(l.id)
        }
    }
    
    var navTitle: String {
        if let lastLevelIndex = session?.lastLevelIndex {
            return "\(course.title) \(lastLevelIndex+1)"
        }
        
        return ""
    }
    
    var hasNextLevel: Bool {
        if let index = session?.lastLevelIndex, index < levels.count - 1 {
            return true
        }
        
        return false
    }
    
    func moveToNextLevel() -> ExerciseLevel? {
        session?.advanceLevel(maxIndex: self.levels.count - 1)
        return currentLevel
    }
    
    func changeLevel(index: Int) {
        session?.changeLevel(
            toLevelIndex: index,
            maxIndex: self.levels.count - 1
        )
    }
    
    func addCompletedLevel(levelProgress: LevelProgress) {
        levelsCompleted[levelProgress.levelID] = true
    }
    
    func loadSession() {
        // TODO:
        // Upon showing a course and its levels, try to find the last course session,
        // regardless of whether it is complete or not so that we could show complete
        // status.
        // In case last session is complete, only create a new one if use clicked
        // Do It Again button.
        isLoading = true
        
        Task(priority: .background) {
            do {
                let levels = try await ExerciseDataSource.shared.loadLevels(for: self.course)
                
                let backgroundContext = ModelContext(DataController.shared)
                
                let (session, levelProgressList) = try await SessionDataSource.shared.loadOrCreateSession(
                    context: backgroundContext,
                    for: self.course,
                )
                
                // [level id : [LevelProgress]
                // Group LevelProgress by level id.
                let groupedLevels = Dictionary(grouping: levelProgressList, by: { $0.levelID })
                
                // [level id : Bool]
                // If user has ever completed a level.
                let levelsCompleted = groupedLevels.mapValues { levelProgresses in
                    // This group has not element (should happen actually)
                    if levelProgresses.count == 0 {
                        return false
                    } else if levelProgresses.count == 1 {
                        // This group has only one element
                        return levelProgresses[0].completed
                    } else {
                        // If a level has mutliple progress, user must have completed it at least onece.
                        return true
                    }
                }
                
                await MainActor.run {
                    self.levels = levels
                    self.session = session
                    self.levelsCompleted = levelsCompleted
                    self.isLoading = false
                }
                
                print("Session loaded. Levels: \(levels.count)")
            } catch {
                print("Failed to load session: \(error)")
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
    
    private func updateSession(modelContext: ModelContext, session: CourseSession) async {
        do {
            try await SessionDataSource.shared.updateSession(
                context: modelContext,
                from: session
            )
        } catch {
            print("error updating course session: \(error.localizedDescription)")
        }
    }
    
    // Update session when a level started.
    func updateSession() {
        guard let session = self.session else {
            return
        }
        
        Task(priority: .background) {
            let backgroundContext = ModelContext(DataController.shared)
            
            await updateSession(modelContext: backgroundContext, session: session)
        }
        
    }
    
    // Try to mark a session as complete every time a level is complete.
    // This is called when summary sheet is popped up.
    func tryCompleteSession() {
        print("try to complete a session")
        
        session?.markComplete()
        // Only update db if it is completed.
        guard let session = self.session, session.isCompleted else {
            return
        }
        
        Task(priority: .background) {
            let backgroundContext = ModelContext(DataController.shared)
            
            await updateSession(modelContext: backgroundContext, session: session)
        }
    }
    
    
    
    static func mock(course: Course) -> CourseViewModel {
        let vm = CourseViewModel(course: course)
        vm.isLoading = false
        vm.error = nil
        vm.levels = ExampleData.allLevels[course.id] ?? []
        vm.session = CourseSession.new(
            courseID: course.id,
        )
        
        return vm
    }
}
