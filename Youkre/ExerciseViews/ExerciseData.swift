//
//  ExerciseData.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/14.
//

struct ExerciseData {
    static let solveEq = "解方程"
    
    static let algebra = [
        Exercise(
            id: "alg-1-1",
            course: .algebra,
            type: .fillInTheBlank,
            difficulty: .beginner,
            title: solveEq,
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
            title: solveEq,
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
            title: solveEq,
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
            id: "alg-1-4",
            course: .algebra,
            type: .fillInTheBlank,
            difficulty: .beginner,
            title: solveEq,
            promptParts: [
                .latex("x − 8 = 7")
            ],
            fillInAnswer: "15",
            multipleChoice: nil,
            explanation: #"""
    开始：

    \[ x − 8 = 7 \]

    等式两边都加上 8:

    \[ x − 8 + 8 = 7 + 8 \]

    算一下 -8 + 8 = 0，7 + 8 = 15，得到：

    \[  x + 0 = 15 \]

    解得：

    \[ x = 15 \]
    """#,
            learnMore: ChapterLink.algebraIntro
        ),
        Exercise(
            id: "alg-1-5",
            course: .algebra,
            type: .fillInTheBlank,
            difficulty: .beginner,
            title: solveEq,
            promptParts: [
                .latex("y + 3 = 9")
            ],
            fillInAnswer: "6",
            multipleChoice: nil,
            explanation: #"""
    开始：

    \[ y + 3 = 9 \]

    等式两边都减去 3:

    \[ y + 3 − 3 = 9 − 3 \]

    算一下 3 − 3 = 0 and 9 − 3 = 6，得到：

    \[  y + 0 = 6 \]

    解得：

    \[ y = 6 \]
    """#,
            learnMore: ChapterLink.algebraIntro
        ),
        Exercise(
            id: "alg-1-6",
            course: .algebra,
            type: .fillInTheBlank,
            difficulty: .beginner,
            title: solveEq,
            promptParts: [
                .latex("7 + y = 12")
            ],
            fillInAnswer: "5",
            multipleChoice: nil,
            explanation: #"""
    开始：

    \[ 7 + y = 12 \]

    等式两边都减去 7:

    \[ 7 − 7 + y = 12 − 7 \]

    算一下 7 − 7 = 0 and 12 − 7 = 5，得到：

    \[  0 + y = 5 \]

    解得：

    \[ y = 5 \]
    """#,
            learnMore: ChapterLink.algebraIntro
        ),
        Exercise(
            id: "alg-1-7",
            course: .algebra,
            type: .fillInTheBlank,
            difficulty: .beginner,
            title: solveEq,
            promptParts: [
                .latex("y − 5 = 9")
            ],
            fillInAnswer: "14",
            multipleChoice: nil,
            explanation: #"""
    开始：

    \[ y − 5 = 9 \]

    等式两边都减去 7:

    \[ y − 5 + 5 = 9 + 5 \]

    算一下 -5 + 5 = 0 and 9 + 5 = 14，得到：

    \[  y + 0 = 14 \]

    解得：

    \[ y = 14 \]
    """#,
            learnMore: ChapterLink.algebraIntro
        ),
        Exercise(
            id: "alg-1-8",
            course: .algebra,
            type: .fillInTheBlank,
            difficulty: .beginner,
            title: solveEq,
            promptParts: [
                .latex("10 − y = 6")
            ],
            fillInAnswer: "4",
            multipleChoice: nil,
            explanation: #"""
    开始：

    \[ 10 − y = 6 \]

    等式两边都减去 10:

    \[ 10 − 10 − y = 6 − 10 \]

    算一下 10 − 10 = 0 and 6 − 10 = -4，得到：

    \[ 0 − y = -4 \]
    
    即：
    
    \[ -y = -4 \]

    解得：

    \[ y = 4 \]
    """#,
            learnMore: ChapterLink.algebraIntro
        ),
        Exercise(
            id: "alg-1-9",
            course: .algebra,
            type: .multipleChoice,
            difficulty: .beginner,
            title: solveEq,
            promptParts: [
                .latex(#"x + 2\frac{1}{2} = 10"#)
            ],
            fillInAnswer: nil,
            multipleChoice: MultipleChoice(
                choices: [
                    #"7\frac{1}{2}"#,
                    #"8\frac{1}{2}"#,
                    #"12\frac{1}{2}"#,
                    #"13\frac{1}{2}"#
                ],
                correctIndex: 0,
                isLatex: true
            ),
            explanation: #"""
    Start with:
    
    \[ x + 2\frac{1}{2} = 10 \]
    
    Subtract 2½ from both sides:
    
    \[ x + 2\frac{1}{2} − 2\frac{1}{2} = 10 − 2\frac{1}{2} \]
    
    A little arithmetic (2½ − 2½ = 0 and 10 − 2½ = 7½) becomes: 
    
    \[ x + 0 = 7\frac{1}{2} \]
    
    Which is just:
    
    \[ x = 7\frac{1}{2} \]
    """#,
            learnMore: ChapterLink.algebraIntro
        ),
        Exercise(
            id: "alg-1-10",
            course: .algebra,
            type: .multipleChoice,
            difficulty: .beginner,
            title: solveEq,
            promptParts: [
                .latex(#"9 − x = 3\frac{1}{2}"#)
            ],
            fillInAnswer: nil,
            multipleChoice: MultipleChoice(
                choices: [
                    #"12\frac{1}{2}"#,
                    #"11\frac{1}{2}"#,
                    #"6\frac{1}{2}"#,
                    #"5\frac{1}{2}"#
                ],
                correctIndex: 3
            ),
            explanation: #"""
    Start with:            
    
    9 − x = 3\frac{1}{2}
    
    Subtract 9 from both sides:    
    
    9 − 9 − x = 3\frac{1}{2} − 9
    
    Some arithmetic:         
    
    0 − x = -5\frac{1}{2}
    
    Which is:              
    
    -x = -5\frac{1}{2}
    
    And so:               
    
    x = 5\frac{1}{2}
    """#,
            learnMore: ChapterLink.algebraIntro
        ),
        
        
        Exercise(
            id: "alg-1-",
            course: .algebra,
            type: .fillInTheBlank,
            difficulty: .beginner,
            title: solveEq,
            promptParts: [
                .latex(#""#)
            ],
            fillInAnswer: "",
            multipleChoice: nil,
            explanation: #"""
    开始：

    \[  \]

    等式两边都加上/减去 :

    \[  \]

    算一下 ，得到：

    \[  \]

    解得：

    \[  \]
    """#,
            learnMore: ChapterLink.algebraIntro
        ),
    ]
    
    static let calculus = [
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
            learnMore: ChapterLink.calChp1
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
                correctIndex: 4,
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
        ),
    ]
}
