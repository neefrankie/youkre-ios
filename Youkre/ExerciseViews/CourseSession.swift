//
//  ExerciseSession.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/5.
//

import Foundation
import SwiftData

struct CourseSession {
    var id: UUID
    var courseID: String
    var startedAt: Date
    var completedAt: Date?
    var levelProgress: [LevelProgress]
}

@Model
class ExerciseSessionEntity {
    @Attribute(.unique) var id: UUID
    var courseID: String
    var startedAt: Date
    var completedAt: Date?
    
    // levels is a 1:N relationship to LevelProgressEntity
    // .cascade ensures cleanup on delete
    @Relationship(deleteRule: .cascade)
    var levels: [LevelProgressEntity] = []
    
    init(courseID: String) {
        self.id = UUID()
        self.courseID = courseID
        self.startedAt = Date()
    }
    
    func toModel() -> CourseSession {
        CourseSession(
            id: id,
            courseID: courseID,
            startedAt: startedAt,
            completedAt: completedAt,
            levelProgress: levels.map { $0.toModel() }
        )
    }
}

struct LevelProgress {
    var id: UUID = UUID()
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
    
    // session: each level belongs to a session
    // SwiftData requires the inverse property to infer relationship semantics
    @Relationship(inverse: \ExerciseSessionEntity.levels)
    var session: ExerciseSessionEntity?
    
    // exercises: each level contains many exercises
    @Relationship(deleteRule: .cascade)
    var exercises: [ExerciseProgressEntity] = []
    
    init(levelID: String, session: ExerciseSessionEntity) {
        self.id = UUID()
        self.levelID = levelID
        self.score = 0
        self.startedAt = Date()
        self.session = session
    }
    
    func toModel() -> LevelProgress {
        LevelProgress(
            id: id,
            levelID: levelID,
            score: score,
            startedAt: startedAt,
            exerciseProgress: [],
        )
    }
}

enum AnswerData: Codable, Hashable {
    case choice(index: Int)
    case choices(indices: [Int])
    case none
}

struct ExerciseState: Codable, Hashable {
    var isAnswered: Bool = false
    var isCorrect: Bool = false
    var skipped: Bool = false
    var answer: AnswerData = .none
    
    static func answered(correct: Bool, answer: AnswerData) -> ExerciseState {
        return ExerciseState(
            isAnswered: true,
            isCorrect: correct,
            skipped: false,
            answer: answer,
        )
    }
    
    static func skipped() -> ExerciseState {
        return ExerciseState(
            isAnswered: false,
            isCorrect: false,
            skipped: true,
            answer: .none
        )
    }
}

struct ExerciseProgress {
    var id: UUID = UUID()
    var exerciseID: String
    var selectedIndex: Int?
    var isCorrect: Bool
    var startedAt: Date
    var completedAt: Date?
    
    var completed: Bool {
        completedAt != nil
    }
    
    mutating func answered(correct: Bool, selectedIndex: Int) {
        self.selectedIndex = selectedIndex
        self.isCorrect = correct
        self.completedAt = .now
    }
}

@Model
class ExerciseProgressEntity {
    @Attribute(.unique) var id: UUID
    var exerciseID: String
    var selectedIndex: Int? // selectedIndex stores choice index (for MC questions)
    var isCorrect: Bool
    var startedAt: Date
    var completedAt: Date? // answeredAt for tracking progress

    // level: back-reference to parent level
    @Relationship(inverse: \LevelProgressEntity.exercises)
    var level: LevelProgressEntity?
    
    init(exerciseID: String) {
        self.id = UUID()
        self.exerciseID = exerciseID
        self.selectedIndex = nil
        self.isCorrect = false
        self.startedAt = Date()
    }
    
    init(from model: ExerciseProgress) {
        self.id = model.id
        self.exerciseID = model.exerciseID
        self.selectedIndex = model.selectedIndex
        self.isCorrect = model.isCorrect
        self.startedAt = model.startedAt
        self.completedAt = model.completedAt
    }
    
    func update(from model: ExerciseProgress) {
        self.selectedIndex = model.selectedIndex
        self.isCorrect = model.isCorrect
        self.completedAt = model.completedAt
    }
    
    func toModel() -> ExerciseProgress {
        ExerciseProgress(
            id: id,
            exerciseID: exerciseID,
            isCorrect: isCorrect,
            startedAt: startedAt,
            completedAt: completedAt
        )
    }
}
