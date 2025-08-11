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
    
    var isLoading = true
    var error: String? = nil
    
    var levels: [ExerciseLevel] = []
    // Data from DB
    var session: CourseSession?
    
    // Used to indicate whether user has ever completed a level.
    var levelsCompleted: [String: Bool] = [:]
    
    var lastLevelIndex: Int {
        session?.lastLevelIndex ?? 0
    }
    
    var currentLevel: ExerciseLevel? {
        print("Level count: \(levels.count), last index: \(session?.lastLevelIndex)")
        if let index = session?.lastLevelIndex, index < levels.count {
            return levels[index]
        }
        
        return nil
    }
    
    var hasNextLevel: Bool {
        lastLevelIndex < levels.count - 1
    }
    
    var allLevelsComplete: Bool {
        levels.allSatisfy { l in
            levelsCompleted.keys.contains(l.id)
        }
    }
    
    var navTitle: String {
        "\(course.title) \(lastLevelIndex+1)"
    }
    
    init(course: Course) {
        self.course = course
    }
    
    func moveToNextLevel() {
        print("Current level \(lastLevelIndex)")
        
        if lastLevelIndex < self.levels.count - 1 {
            session?.lastLevelIndex = lastLevelIndex + 1
            print("Advanced to level \(lastLevelIndex)")
        }
    }
    
    func markLevelComplete(levelProgress: LevelProgress) {
        levelsCompleted[levelProgress.levelID] = true
        // TODO: also check all levels are complete.
    }
    
    @MainActor
    func updateSession(context: ModelContext) async {

        print("hasNextLevel: \(hasNextLevel). Last level index: \(session?.lastLevelIndex ?? -1). Level count: \(levels.count)")
        
        guard let session = self.session else {
            return
        }
        
        do {
            try await SessionDataSource.shared.updateSession(
                from: session,
                context: context
            )
        } catch {
            print("error syncing last level: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func loadSession(context: ModelContext) async {
        // TODO:
        // Upon showing a course and its levels, try to find the last course session,
        // regardless of whether it is complete or not so that we could show complete
        // status.
        // In case last session is complete, only create a new one if use clicked
        // Do It Again button.
        isLoading = true
        
        do {
            let levels = await ExerciseDataSource.shared.loadLevels(for: self.course)
            var session = try await SessionDataSource.shared.loadOrCreateSession(
                for: self.course,
                levelCount: levels.count,
                context: context
            )
            
            // [level id : [LevelProgress]
            // Group LevelProgress by level id.
            let groupedLevels = Dictionary(grouping: session.levelProgress, by: { $0.levelID })
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
            session.levelProgress = []
            
            self.levels = levels
            self.session = session
            self.levelsCompleted = levelsCompleted
            
            print("Session loaded. Levels: \(levels.count). LastLevelIndex: \(lastLevelIndex)")
            print(session)
        } catch {
            print("Failed to load session: \(error)")
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    static func mock(course: Course) -> CourseViewModel {
        let vm = CourseViewModel(course: course)
        vm.isLoading = false
        vm.error = nil
        vm.levels = LevelData.allLevels[course.id] ?? []
        vm.session = CourseSession.new(
            courseID: course.id,
            levelCount: vm.levels.count
        )
        
        return vm
    }
}
