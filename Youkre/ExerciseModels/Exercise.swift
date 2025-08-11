//
//  Exercise.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/10.
//

import Foundation
import SwiftData


struct Exercise: Identifiable, Codable {
    var id: String
    var course: CourseKind     // TODO: remove
    let promptParts: [PromptBlock]
    var multipleChoice: MultipleChoice?
    var explanation: String?
    var learnMore: ChapterLink
    
    var correctAnswer: String {
        return multipleChoice?.correctAnswer ?? ""
    }
}

struct MultipleChoice: Codable {
    var choices: [String]
    var correctIndex: Int
    var isLatex: Bool = false
    
    var correctAnswer: String {
        return choices[correctIndex]
    }
}

struct ChoiceItem: Codable {
    var text: String
    var correct: Bool
    var isLatex: Bool = false
}

struct ExerciseV3: Identifiable, Codable {
    var id: String
    var prompts: [PromptBlock]
    var multipleChoice: [ChoiceItem]
    var explanation: String?
}

struct ExerciseV2: Identifiable, Codable {
    var id: String
    var prompts: [PromptBlock]
    var multipleChoice: MultipleChoice
    var explanation: String?
}


struct ExerciseProgress {
    var id: UUID
    var exerciseID: String
    var selectedIndex: Int?
    var isCorrect: Bool
    var startedAt: Date
    var completedAt: Date?
    
    var isCompleted: Bool {
        completedAt != nil
    }
    
    var isSkipped: Bool {
        selectedIndex == nil && completedAt == nil
    }
        
    mutating func answered(correct: Bool, selectedIndex: Int) {
        self.selectedIndex = selectedIndex
        self.isCorrect = correct
    }
    
    static func new(exerciseID: String) -> ExerciseProgress {
        ExerciseProgress(
            id: UUID(),
            exerciseID: exerciseID,
            selectedIndex: nil,
            isCorrect: false,
            startedAt: Date(),
            completedAt: nil
        )
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
    @Relationship(inverse: \LevelProgressEntity.exerciseProgress)
    var levelProgress: LevelProgressEntity?
    
    init(exerciseID: String, level: LevelProgressEntity) {
        self.id = UUID()
        self.exerciseID = exerciseID
        self.selectedIndex = nil
        self.isCorrect = false
        self.startedAt = Date()
        self.levelProgress = level
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
            selectedIndex: selectedIndex,
            isCorrect: isCorrect,
            startedAt: startedAt,
            completedAt: completedAt
        )
    }
}

enum AnswerData: Codable, Hashable {
    case choice(index: Int)
    case choices(indices: [Int])
    case none
}
