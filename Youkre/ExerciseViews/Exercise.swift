//
//  Exercise.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/10.
//

import Foundation

enum DifficultyLevel: Int, Codable {
    case beginner = 1  // 初级
    case intermediate // 中级
    case advanced     // 高级
    
    var description: String {
        switch self {
        case .beginner:
            return "初级"
        case .intermediate:
            return "中级"
        case .advanced:
            return "高级"
        }
    }
}

enum ExerciseType: String, Codable {
    case fillInBlank
    case multipleChoice
}

struct MultipleChoice: Codable {
    var choices: [String]
    var correctIndex: Int
    var isLatex: Bool = false
    
    var correctAnswer: String {
        return choices[correctIndex]
    }
}

struct Exercise: Identifiable, Codable {
    var id: String
    var course: CourseKind     // TODO: use Course id
    let promptParts: [PromptBlock]
    
    // For multiple choice
    var multipleChoice: MultipleChoice?
    var explanation: String?
    var learnMore: ChapterLink
    
    var correctAnswer: String {
        return multipleChoice?.correctAnswer ?? ""
    }
}

enum AnswerData: Codable, Hashable {
    case text(String) // Deprecated
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




