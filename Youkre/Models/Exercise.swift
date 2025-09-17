//
//  Exercise.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/10.
//

import Foundation
import SwiftData

struct MultipleChoice: Codable {
    var choices: [String]
    var correctIndex: Int
    var isLatex: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case choices = "choices"
        case correctIndex = "correct_index"
        case isLatex = "is_latex"
    }
    
    var correctAnswer: String {
        return choices[correctIndex]
    }
}



struct Exercise: Identifiable, Codable, Equatable {
    var id: String
    var levelId: String
    var prompts: String
    var multipleChoice: MultipleChoice
    var explanation: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case levelId = "level_id"
        case prompts = "prompts"
        case multipleChoice = "multiple_choice"
        case explanation = "explanation"
    }
    
    static func ==(lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
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
        self.completedAt = Date()
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

// An Exercise has only one ExerciseProgressEntity under a certain LevelProgressEntity.
// We do not allow user to redo the same exercise again and again under a specific
// LevelProgressEntity. An exercise has only 4 choices. Once selected, freeze it.
// It would be meaningless if we generate multiple ExerciseProgressEntity
// under a LevelProgressEntity, which would indicate that every click of the 4 choice creates
// a new row, meaningless.
@Model
class ExerciseProgressEntity {
    @Attribute(.unique) var id: UUID
    var exerciseID: String
    var selectedIndex: Int? // selectedIndex stores choice index (for MC questions)
    var isCorrect: Bool
    var startedAt: Date
    var completedAt: Date? // answeredAt for tracking progress
    
//    var levelProgressId: String

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
