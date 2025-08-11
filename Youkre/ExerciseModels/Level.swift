//
//  ExerciseSession.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/5.
//

import Foundation
import SwiftData

struct ExerciseLevel: Identifiable, Hashable {
    var id: String
    var courseID: String
    var courseSlug: String
    var chapterID: String
    var chapterSlug: String
    var title: String
    var index: Int
    var contentVersoin: Int = 1
    var exercises: [ExerciseV2] = []
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: ExerciseLevel, rhs: ExerciseLevel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct LevelProgress {
    var id: UUID
    var levelID: String
    var score: Int
    var startedAt: Date
    var completedAt: Date?
    var exerciseProgress: [ExerciseProgress]
    
    var completed: Bool {
        completedAt != nil
    }
}

@Model
class LevelProgressEntity {
    @Attribute(.unique) var id: UUID
    var levelID: String
    var score: Int
    var startedAt: Date
    var completedAt: Date?
    var levelContentVersion: Int
    
    // session: each level belongs to a session
    // SwiftData requires the inverse property to infer relationship semantics
    @Relationship(inverse: \CourseSessionEntity.levelProgress)
    var courseSession: CourseSessionEntity?
    
    // exercises: each level contains many exercises
    @Relationship(deleteRule: .cascade)
    var exerciseProgress: [ExerciseProgressEntity] = []
    
    init(level: ExerciseLevel, session: CourseSessionEntity) {
        self.id = UUID()
        self.levelID = level.id
        self.score = 0
        self.startedAt = Date()
        self.levelContentVersion = level.contentVersoin
        self.courseSession = session
    }
    
    func toModel(withExercise: Bool = false) -> LevelProgress {
        LevelProgress(
            id: id,
            levelID: levelID,
            score: score,
            startedAt: startedAt,
            exerciseProgress: withExercise
                ? exerciseProgress.map { $0.toModel() }
                : [],
        )
    }
}



