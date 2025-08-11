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
    
    var learnMore: ChapterLink {
        ChapterLink(
            courseSlug: courseSlug,
            chapterSlug: chapterSlug
        )
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: ExerciseLevel, rhs: ExerciseLevel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct LevelDetailParams: Hashable {
    let level: ExerciseLevel
    let index: Int
    let courseViewModel: CourseViewModel
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(level.id)
    }
    
    static func ==(lhs: LevelDetailParams, rhs: LevelDetailParams) -> Bool {
        return lhs.level.id == rhs.level.id
    }
    
    var navTitle: String {
        "\(courseViewModel.course.title) \(index+1)"
    }
}

// State data for an ExerciseLevel.
// Under a specific course session, an ExerciseLevel may have multiple LevelProgress.
// However, there's should be at most one row with null completedAt field.
// Once a LevelProgress is completed, you should not touch it again.
struct LevelProgress {
    var id: UUID
    var levelID: String
    var score: Int // TODO: also record how many exercises in this level?
    var total: Int // Total number of exercises
    var startedAt: Date
    var completedAt: Date?
    var lastExerciseIndex: Int?
    var exerciseProgress: [ExerciseProgress]
    
    var completed: Bool {
        completedAt != nil
    }
    
    mutating func moveExercise(lastIndex: Int, score: Int, finished: Bool = false) {
        self.score = score
        if lastIndex <= total - 1 {
            self.lastExerciseIndex = lastIndex
        }
        self.completedAt = finished ? Date() : nil
    }
    
    static func new(levelID: String, exerciseCount: Int) -> LevelProgress {
        LevelProgress(
            id: UUID(),
            levelID: levelID,
            score: 0,
            total: exerciseCount,
            startedAt: Date(),
            completedAt: nil,
            lastExerciseIndex: nil,
            exerciseProgress: []
        )
    }
}

// levelID + courseSession.id should be combined unique
// in SQL terms.
@Model
class LevelProgressEntity {
    @Attribute(.unique) var id: UUID
    var levelID: String
    var score: Int
    var total: Int
    var startedAt: Date
    var completedAt: Date?
    var lastExerciseIndex: Int?
    var levelContentVersion: Int
    
    var courseSessionID: UUID
    // session: each level belongs to a session
    // SwiftData requires the inverse property to infer relationship semantics
    @Relationship(inverse: \CourseSessionEntity.levelProgress)
    var courseSession: CourseSessionEntity?
    
    // exercises: each level contains many exercises
    @Relationship(deleteRule: .cascade)
    var exerciseProgress: [ExerciseProgressEntity] = []
    
    init(for level: ExerciseLevel, exerciseCount: Int, of session: CourseSessionEntity) {
        self.id = UUID()
        self.levelID = level.id
        self.score = 0
        self.total = exerciseCount
        self.startedAt = Date()
        self.lastExerciseIndex = nil
        self.levelContentVersion = level.contentVersoin
        self.courseSessionID = session.id
        self.courseSession = session
    }
    
    func update(from model: LevelProgress) {
        self.score = model.score
        self.total = model.total
        self.completedAt = model.completedAt
        self.lastExerciseIndex = model.lastExerciseIndex
    }
    
    func toModel(withExercise: Bool = false) -> LevelProgress {
        LevelProgress(
            id: id,
            levelID: levelID,
            score: score,
            total: total,
            startedAt: startedAt,
            lastExerciseIndex: lastExerciseIndex,
            exerciseProgress: withExercise
                ? exerciseProgress.map { $0.toModel() }
                : [],
        )
    }
}



