//
//  Exercise.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/10.
//

import Foundation

enum SubjectCategory: String {
    case algebra       // 代数
    case calculus      // 微积分
    case probability   // 概率
    case geometry      // 几何
    case physics       // 物理
    case trigonometry  // 三角函数
}

enum DifficultyLevel: Int {
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
    case fillInTheBlank
    case multipleChoice
}

struct Exercise: Identifiable {
    let id = UUID()
    let subject: SubjectCategory     // 题目类别，如 "代数" 或 "微积分"
    let type: ExerciseType
    let difficulty: DifficultyLevel      // 难度等级，1-5
    let title: String        // 题目标题
    let prompt: String      // 题目内容
    // For fill-in-the-blank
    let fillInAnswer: String?
    
    // For multiple choice
    let multiple: MultipleChoice?
    
    let explanation: String?
    let learnMoreSlug: String?
    
//    let hints: [String]?     // 可选提示
}

struct MultipleChoice {
    let choices: [String]
    let correctIndex: Int
}

struct Subject {
    var name: String          // 科目名称，如 "代数"
    var exercises: [Exercise] // 该科目下的练习题数组
}

let sampleExercises: [Exercise] = [
    Exercise(
        subject: .algebra,
        type: .fillInTheBlank,
        difficulty: .beginner,
        title: "equation-01",
        prompt: #"Solve \( 2x + 3 = 7 \), find \( x = \underline{\hspace{2cm}} \)"#,
        fillInAnswer: "2",
        multiple: nil,
        explanation: "Subtract 3 from both sides: 2x = 4 → x = 2",
        learnMoreSlug: "linear-equations"
    ),
    Exercise(
        subject: .calculus,
        type: .multipleChoice,
        difficulty: .intermediate,
        title: "quadratic-01",
        prompt: #"x^2 - 4 = 0"#,
        fillInAnswer: nil,
        multiple: MultipleChoice(
            choices: [
                #"x = 2"#,
                #"x = -2"#,
                #"x = ±2"#,
                #"x = 0"#
            ],
            correctIndex: 2,
        ),
        explanation: "The equation factors as (x - 2)(x + 2) = 0, so x = ±2.",
        learnMoreSlug: "solving-quadratic"
    ),
    Exercise(
        subject: .calculus,
        type: .multipleChoice,
        difficulty: .intermediate,
        title: "derivative-01",
        prompt: #"\\( \\ln x \\)"#,
        fillInAnswer: nil,
        multiple: MultipleChoice(
            choices: [
                #"1/x"#,
                #"x"#,
                #"e^x"#,
                #"x ln x"#
            ],
            correctIndex: 0,
        ),
        explanation: "By definition, the derivative of ln(x) is 1/x.",
        learnMoreSlug: "derivatives-log"
    )
]
