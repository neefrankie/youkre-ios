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
    case fillInTheBlank
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
    var course: Course     // 题目类别，如 "代数" 或 "微积分"
    var type: ExerciseType
    var difficulty: DifficultyLevel      // 难度等级，1-5
    var title: String        // 题目标题
    // 题目内容
    let promptParts: [PromptPart]
    // For fill-in-the-blank
    var fillInAnswer: String?
    
    // For multiple choice
    var multipleChoice: MultipleChoice?
    
    var explanation: String?
    var learnMore: ChapterLink
    
//    let hints: [String]?     // 可选提示
    
    var correctAnswer: String {
        switch self.type {
        case .fillInTheBlank:
            return fillInAnswer ?? ""
        case .multipleChoice:
            return multipleChoice?.correctAnswer ?? ""
        }
    }
}

enum AnswerData: Codable, Hashable {
    case text(String)
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
            isAnswered: true,
            isCorrect: false,
            skipped: true,
            answer: .none
        )
    }
}

struct Subject {
    var name: String          // 科目名称，如 "代数"
    var exercises: [Exercise] // 该科目下的练习题数组
}

struct Voc {
    static let solveEq = "解方程"
}

let sampleExercises: [Exercise] = [
    Exercise(
        id: "alg-1-1",
        course: .algebra,
        type: .fillInTheBlank,
        difficulty: .beginner,
        title: Voc.solveEq,
        promptParts: [
            .latex("x + 2 = 6")
        ],
        fillInAnswer: "4",
        multipleChoice: nil,
        explanation: #"""
开始：

\[ x + 2 = 6 \]

等式两边都减去 2:

\[ x + 2 - 2 = 6 - 2 \]

算一下 2 - 2 = 0，6 - 2 = 4，得到：

\[ x + 0 = 4 \]

解得：

\[ x = 4\]
"""#,
        learnMore: ChapterLink.algebraIntro
    ),
    Exercise(
        id: "alg-1-2",
        course: .algebra,
        type: .fillInTheBlank,
        difficulty: .beginner,
        title: Voc.solveEq,
        promptParts: [
            .latex("x + 5 = 11")
        ],
        fillInAnswer: "6",
        multipleChoice: nil,
        explanation: #"""
开始：

\[ x + 5 = 11 \]

等式两边都减去 5:

\[ x + 5 - 5 = 11 - 5 \]

算一下 5 - 5 = 0，11 - 5 = 6，得到：

\[ x + 0 = 6 \]

解得：

\[ x = 6\]
"""#,
        learnMore: ChapterLink.algebraIntro
    ),
    Exercise(
        id: "alg-1-3",
        course: .algebra,
        type: .fillInTheBlank,
        difficulty: .beginner,
        title: Voc.solveEq,
        promptParts: [
            .latex("x - 3 = 8")
        ],
        fillInAnswer: "11",
        multipleChoice: nil,
        explanation: #"""
开始：

\[ x − 3 = 8 \]

等式两边都减去 5:

\[ x − 3 + 3 = 8 + 3 \]

算一下 -3 + 3 = 0，8 + 3 = 11，得到：

\[ x + 0 = 11 \]

解得：

\[ x = 11 \]
"""#,
        learnMore: ChapterLink.algebraIntro
    ),
    Exercise(
        id: "cal-1-1",
        course: .calculus,
        type: .multipleChoice,
        difficulty: .beginner,
        title: "𝑑𝑥 在微积分中表示什么？",
        promptParts: [],
        fillInAnswer: nil,
        multipleChoice: MultipleChoice(
            choices: [
                "𝑑 乘以 𝑥",
                "𝑥 的微小部分",
                "一个函数",
                "函数在 𝑥 点的值"
            ],
            correctIndex: 1,
        ),
        explanation: "The equation factors as (x - 2)(x + 2) = 0, so x = ±2.",
        learnMore: ChapterLink(
            bookSlug: DataStore.bookList[0].slug,
            chapterSlug: "1"
        )
    ),
    Exercise(
        id: "cal-1-2",
        course: .calculus,
        type: .multipleChoice,
        difficulty: .beginner,
        title: "∫𝑑𝑥 在微积分中表示什么？",
        promptParts: [],
        fillInAnswer: nil,
        multipleChoice: MultipleChoice(
            choices: [
                "",
                "",
                "",
                "所有 𝑥 的小部分的总和"
            ],
            correctIndex: 3
        ),
        learnMore: ChapterLink.calChp1
    ),
    Exercise(
        id: "cal-3-1",
        course: .calculus,
        type: .multipleChoice,
        difficulty: .beginner,
        title: "什么是导数？",
        promptParts: [],
        fillInAnswer: nil,
        multipleChoice: MultipleChoice(
            choices: [
                "",
                "",
                "一个函数，描述原函数在每个点上的斜率",
                ""
            ],
            correctIndex: 2
        ),
        learnMore: ChapterLink.calChp3
    ),
    Exercise(
        id: "cal-3-2",
        course: .calculus,
        type: .multipleChoice,
        difficulty: .beginner,
        title: "下面的符号表示什么？",
        promptParts: [
            .latex(#"\frac{dy}{dx}"#)
        ],
        fillInAnswer: nil,
        multipleChoice: MultipleChoice(
            choices: [
                "𝑦 关于 𝑥 的导数",
                "𝑑𝑦 除以 𝑑𝑥",
                "",
                ""
            ],
            correctIndex: 0
        ),
        learnMore: ChapterLink.calChp3
    ),
    Exercise(
        id: "cal-4-1",
        course: .calculus,
        type: .multipleChoice,
        difficulty: .intermediate,
        title: "以下函数的导数是什么？",
        promptParts: [
            .latex(#"x^n"#)
        ],
        fillInAnswer: nil,
        multipleChoice: MultipleChoice(
            choices: [
                #"x^{n-1}"#,
                #"x"#,
                #"e^x"#,
                #"nx^{n-1}"#
            ],
            correctIndex: 3,
            isLatex: true
        ),
        explanation: "By definition, the derivative of ln(x) is 1/x.",
        learnMore: ChapterLink.calChp4
    ),
    Exercise(
        id: "cal-6",
        course: .calculus,
        type: .multipleChoice,
        difficulty: .intermediate,
        title: "以下函数的导数是什么？",
        promptParts: [
            .latex(#"ln(x)"#)
        ],
        fillInAnswer: nil,
        multipleChoice: MultipleChoice(
            choices: [
                #"\frac{1}{x}"#,
                #"x"#,
                #"e^x"#,
                #"x\cdot ln(x)"#
            ],
            correctIndex: 0,
            isLatex: true
        ),
        explanation: "By definition, the derivative of ln(x) is 1/x.",
        learnMore: ChapterLink.calChp4
    )
]
