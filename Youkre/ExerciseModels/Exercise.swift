//
//  Exercise.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/10.
//

import Foundation



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

struct ExerciseV2: Identifiable, Codable {
    var id: String
    var prompts: [PromptBlock]
    var multipleChoice: MultipleChoice
    var explanation: String?
}


