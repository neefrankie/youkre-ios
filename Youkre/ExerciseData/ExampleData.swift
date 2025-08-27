//
//  ExerciseDataV2.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/6.
//

struct ExampleData {
    
    static let allLevels: [String: [ExerciseLevel]] = [
        cmeID: cmeLevels,
        algebraID: algebra,
        statID: stats,
        trigID: trignometry,
    ]
    
    static let cmeID = "crs-5bd2c24bd901b5a9"
    static let cmeSlug = "calculus-made-easy"
    
    static let algebraID = "crs-6b927048e42cc585"
    static let algebraSlug = "elementary-algebra"
    
    static let statID = "crs-ad7dd3035d82eda3"
    static let statSlug = "elementary-statistics"
    
    static let trigID = "crs-9b08c5f3f19338c4"
    static let trigSlug = "elementary-trigonometry"
    
    static let courses: [Course] = [
        Course(
            id: cmeID,
            slug: cmeSlug,
            title: "简易微积分",
            contentVersion: 1,
        ),
        Course(
            id: algebraID,
            slug: algebraSlug,
            title: "初级代数",
            contentVersion: 1,
        ),
        Course(
            id: statID,
            slug: statSlug,
            title: "概率统计入门",
            contentVersion: 1,
        ),
        Course(
            id: trigID,
            slug: trigSlug,
            title: "三角函数",
            contentVersion: 1,
        )
    ]
    
    static let cmeLevel1Ex = [
        Exercise(
            id: "cme-1-a",
            levelId: "lvl-5353106dd4b461a9",
            prompts: [
                .latex("dx"),
                .text("在微积分中表示什么？")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "𝑑 乘以 𝑥",
                    "𝑥 的微小部分",
                    "一个函数",
                    "函数在 𝑥 点的值"
                ],
                correctIndex: 1,
            ),
            explanation: """
在微积分中，不要把 𝑑𝑥 看成是 𝑑 乘以 𝑥。

𝑑 并不是一个因子，它的意思是“……的一个微小部分”或“……的一个微量”。

𝑑𝑥 指的是 𝑥 的一点点；𝑑𝑢 表示 𝑢 的一点点。

𝑑𝑥 应该读作“dee-eks”。
""",
        ),
        Exercise(
            id: "cme-1-b",
            levelId: "cme-chp-1",
            prompts: [
                .text("∫𝑑𝑥 在微积分中表示什么？")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "函数的导数",
                    "函数在某一点的斜率",
                    "函数的极限值",
                    "所有 𝑥 的小部分的总和"
                ],
                correctIndex: 3
            ),
            explanation: """
∫ 可以看作变长的 S，英文单词“sum”的第一个字母，可以称为“总和”。

如果 𝑥 被看作由很多小部分组成，每个部分称为 𝑑𝑥，当把它们全部加起来时，就得到了所有 𝑑𝑥 的总和，也就是 𝑥。

∫𝑑𝑥 指的是所有 𝑥 的小部分的总和；∫𝑑𝑡 指的是所有 𝑡 的小部分的总和。
""",
        ),
    ]
    
    static let cmeLevel2Ex = [
        Exercise(
            id: "cme-3-a",
            levelId: "cme-chp-3",
            prompts: [
                .text("什么是导数？")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "函数图像与 𝑥 轴之间区域的面积",
                    "函数值在无限小间隔内的平均变化率",
                    "函数图像上某一点处切线的斜率",
                    "一个函数从负无穷到正无穷的积分值"
                ],
                correctIndex: 2
            ),
            explanation: """
导数是一个关于 𝑥 的函数，用来描述原函数每个点上的瞬时变化率。

对于定义域内的每一个 x，导数给出了原函数在该点处的斜率，即随着 𝑥 的微小变化，原函数变化的速率。

通过研究导数函数，可以了解原始函数的性质，比如在哪里增加或减少、凹凸性等。 

你可以在本应用的“图示”部分观察不同函数的斜率变化。       
""",
        ),
        Exercise(
            id: "cme-3-b",
            levelId: "cme-chp-3",
            prompts: [
                .text("下面的符号表示什么？"),
                .latex(#"\frac{dy}{dx}"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "函数 𝑦 关于变量 𝑥 的导数",
                    "𝑑𝑦 除以 𝑑𝑥",
                    "函数 𝑦 关于变量 𝑥 的积分",
                    "函数 𝑥 关于变量 𝑦 的导数"
                ],
                correctIndex: 0
            ),
            explanation: #"""
我们用符号

\[ \frac{dy}{dx} \]

来表示函数 𝑦 关于变量 𝑥 的导数。

找出这个函数的过程叫做求导。
"""#,
        ),
    ]
    
    static let cmeLevel3Ex = [
        Exercise(
            id: "cme-4-a",
            levelId: "cme-chp-4",
            prompts: [
                .text("以下函数的导数是什么？"),
                .latex(#"x^n"#)
            ],
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
            explanation: #"""
这是求导法则中最基本的幂法则：

\[ \frac{d}{dx} x^a = ax^{a-1} \]
"""#,
        ),
        Exercise(
            id: "cme-4-1",
            levelId: "cme-chp-4",
            prompts: [
                .text("求以下函数的导数："),
                .latex(#"y = x^{13}"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    #"12x^{12}"#,
                    #"13x^{12}"#,
                    #"13x^{14}"#,
                    #"14x^{13}"#,
                ],
                correctIndex: 1,
                isLatex: true
            ),
            explanation: #"""
根据幂法则：

$$
\frac{d}{dx}x^a = ax^{a-1}
$$

这里 a = 13，所以：

\begin{align*}
&\frac{d}{dx}x^{13} \\
= &13x^{13-1} \\
= &13x^{12}
\end{align*}
"""#,
        ),
    ]
    
    static var cmeLevels: [ExerciseLevel] = [
        ExerciseLevel(
            id: "lvl-5353106dd4b461a9",
            courseID: cmeID,
            courseSlug: cmeSlug,
            chapterID: "",
            chapterSlug: "1",
            title: "",
            index: 0,
            exercises: cmeLevel1Ex,
        ),
        ExerciseLevel(
            id: "lvl-7ed0198d9df80f66",
            courseID: cmeID,
            courseSlug: cmeSlug,
            chapterID: "",
            chapterSlug: "3",
            title: "",
            index: 1,
            exercises: cmeLevel2Ex
        ),
        ExerciseLevel(
            id: "lvl-b841a5cf93b68e42",
            courseID: cmeID,
            courseSlug: cmeSlug,
            chapterID: "",
            chapterSlug: "4",
            title: "",
            index: 2,
            exercises: cmeLevel3Ex
        ),
    ]
    
    static let solveEq = "解方程"
    static let opOrder = "算一算下式等于多少？注意运算顺序"
    
    static let algebraLevel1Ex = [
        Exercise(
            id: "algebra-introduction-1",
            levelId: "algebra-chp-1",
            prompts: [
                .text(solveEq),
                .latex("x + 2 = 6")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "1",
                    "4",
                    "8",
                    "3"
                ],
                correctIndex: 1
            ),
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
        ),
        Exercise(
            id: "algebra-introduction-2",
            levelId: "algebra-chp-1",
            prompts: [
                .text(solveEq),
                .latex("x + 5 = 11")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "6",
                    "16",
                    "5",
                    "7",
                ],
                correctIndex: 0
            ),
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
        ),
    ]
    
    static let algebraLevel2Ex = [
        Exercise(
            id: "algebra-introduction-multiply-1",
            levelId: "algebra-chp-2",
            prompts: [
                .text(solveEq),
                .latex(#"3x = 12"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "4",
                    "3",
                    "2",
                    "6"
                ],
                correctIndex: 0
            ),
            explanation: #"""
开始:

\[ 3x = 12 \]

两边都除以 3: 

\[ \frac{3x}{3} = \frac{12}{3} \]

算一算 ( 3/3 = 1，12/3 = 4) 得到: 

\[ 1x = 4 \]

解得: 

\[ x = 4 \]
"""#,
        ),
        Exercise(
            id: "algebra-introduction-multiply-2",
            levelId: "algebra-chp-2",
            prompts: [
                .text(solveEq),
                .latex(#"5x = 30"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "5",
                    "10",
                    "7",
                    "6"
                ],
                correctIndex: 3
            ),
            explanation: #"""
开始:

\[ 5x = 30 \]

两边都除以 5: 

\[ \frac{5x}{5} = \frac{30}{5} \]

算一算 ( 5/5 = 1，30/5 = 6) 得到: 

\[ 1x = 6 \]

解得: 

\[ x = 6 \]
"""#,
        ),
    ]
    
    static let algebraLevel3Ex = [
        Exercise(
            id: "operation-order-pemdas-exercise-9",
            levelId: "algebra-chp-3",
            prompts: [
                .text(opOrder),
                .latex(#"(7 - \sqrt{9}) \times (4^2 - 3 + 1)"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "20",
                    "56",
                    "14",
                    "52"
                ],
                correctIndex: 1
            ),
            explanation: #"""
运算顺序是：

* 先算括号（如果有）  
* 然后是指数（幂、平方根等）  
* 接着是乘法和除法（从左到右）  
* 最后是加法和减法（从左到右）

先算出括号里面的数。这里有两对括号，一步一步来算。

首先算括号里面：

\[ 7 - \sqrt{9} \]

先算开方：

\[ 7 - \sqrt{9} = 7 - 3 \]

再算减法：

\[ 7 - 3 = 4 \]

第二对括号：

\[ 4^2 - 3 + 1 \]

先算幂：

\[ 4^2 - 3 + 1 = 16 - 3 + 1 \]

再做减法：

\[ 16 - 3 + 1 = 13 + 1 \]

然后是加法：

\[ 13 + 1 = 14 \]

现在括号里面简化了，最后一步是乘法：

\begin{align*}
&(7 - \sqrt{9}) \times (4^2 - 3 + 1) \\
= &4 \times 14 \\
= &56 
\end{align*}

再来一行一行地看一遍:

\begin{align*}
&(7 - √9) \times (4^2 - 3 + 1) \\
= &(7 - 3) \times (4^2 - 3 + 1) \\
= &4 \times (4^2 - 3 + 1) \\
= &4 \times (16 - 3 + 1) \\
= &4 \times (13 + 1) \\
= &4 \times 14 \\
= &56  
\end{align*}
"""#,
        ),
        Exercise(
            id: "operation-order-pemdas-exercise-10",
            levelId: "algebra-chp-3",
            prompts: [
                .text(opOrder),
                .latex(#"\frac{2^4 + (16 - 3 \times 4)}{(6 + 3^2) \div (7 - 4)}"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "20",
                    "3",
                    "5",
                    "4"
                ], correctIndex: 3
            ),
            explanation: #"""
运算顺序是：

* 先算括号（如果有）  
* 然后是指数（幂、平方根等）  
* 接着是乘法和除法（从左到右）  
* 最后是加法和减法（从左到右）

这个问题包含一个分数形式，我们需要先分别化简分子和分母。

1. 分子

\[ 2^4 + (16 - 3 \times 4) \]

我们首先要化简括号内的部分：

\[ (16 - 3 \times 4) \]

在括号内，先进行乘法运算：

\[ 16 - 3 \times 4 = 16 - 12 \]

然后进行减法：

\[ 16 - 12 = 4 \]

接下来计算幂运算：

\[ 24 = 2 \times 2 \times 2 \times 2 = 16 \]

把分子的两个部分加在一起：

\[ 24 + (16 - 3 \times 4) = 16 + 4 \]

再进行加法：

\[ 16 + 4 = 20 \]

我们已经将分子尽可能化简，结果是 20。

2. 分母

\[ (6 + 3^2) \div (7 - 4) \]

这里有两组括号，我们必须先分别化简每组括号中的内容：

第一组括号里面是：

\[ (6 + 3^2) \]

先计算指数：

\[ (6 + 32)= 6 + 9 \] 

然后进行加法：

\[ 6 + 9 = 15 \]

第二组括号：

\[ (7 - 4) = 3 \]

现在我们可以计算整个分母:

\begin{align*}
&(6 + 32) \div (7 - 4) \\
= &15 \div 3 \\
= &5
\end{align*}

我们已经将分母尽可能化简，结果是 5。

最后，将分子除以分母，得到最终结果：

\begin{align*}
&\frac{2^4 + (16 - 3 \times 4)}{(6 + 3^2) \div (7 - 4)} \\
= &\frac{20}{5} \\
= &4
\end{align*}
"""#,
        ),
    ]
    
    static let algebra: [ExerciseLevel] = [
        ExerciseLevel(
            id: "algebra-chp-1",
            courseID: algebraID,
            courseSlug: algebraSlug,
            chapterID: "",
            chapterSlug: "introduction",
            title: "",
            index: 1,
            exercises: algebraLevel1Ex
        ),
        ExerciseLevel(
            id: "algebra-chp-2",
            courseID: algebraID,
            courseSlug: algebraSlug,
            chapterID: "",
            chapterSlug: "introduction-multiply",
            title: "",
            index: 2,
            exercises: algebraLevel2Ex,
        ),
        ExerciseLevel(
            id: "algebra-chp-3",
            courseID: algebraID,
            courseSlug: algebraSlug,
            chapterID: "",
            chapterSlug: "operation-order-pemdas",
            title: "",
            index: 3,
            exercises: algebraLevel3Ex,
        ),
    ]
    
    static let stats: [ExerciseLevel] = [
        ExerciseLevel(
            id: "stats-chp-1",
            courseID: statID,
            courseSlug: statSlug,
            chapterID: "",
            chapterSlug: "central-meausres",
            title: "",
            index: 1,
            exercises: [
                Exercise(
                    id: "central-meausres-exercise-4",
                    levelId: "stats-chp-1",
                    prompts: [
                        .text("下表显示了北京每个月的平均气温："),
                        .table(GridTable(
                            data: [
                                ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月",],
                                ["1", "5", "11", "20", "26", "30", "30", "29", "25", "19", "10", "3"],
                            ],
                            horizontal: true
                        )),
                        .text("请问一年的平均气温是多少度？")
                    ],
                    multipleChoice: MultipleChoice(
                        choices: [
                            "19.5°C",
                            "17.4°C",
                            "20°C",
                            "30°C"
                        ],
                        correctIndex: 1
                    ),
                    explanation: #"""
要计算平均值，可以按照以下步骤：

* 把所有气温加起来，
* 然后除以总共有多少个月。

气温总和 = 1 + 5 + 11 + 20 + 26 + 30 + 30 + 29 + 25 + 19 + 10 + 3 = 209

一共是 12 个月：

\[ 209 \div 12 \approx 17.4 \]

所以，平均气温是 17.4°C。
"""#,
                ),
                Exercise(
                    id: "central-meausres-exercise-7",
                    levelId: "stats-chp-1",
                    prompts: [
                        .text("小艾掷骰子多次，并将结果用柱状图表示出来，如下所示："),
                        .image("central-meausres-exercise-7"),
                        .text("平均得分是多少？")
                    ],
                    multipleChoice: MultipleChoice(
                        choices: [
                            "3",
                            "3.5",
                            "4",
                            "6.67"
                        ],
                        correctIndex: 1
                    ),
                    explanation: #"""
根据图表，各点数出现的次数为： 

* 1 出现了 7 次，  
* 2 出现了 8 次，  
* 3 出现了 6 次，  
* 4 出现了 4 次，  
* 5 出现了 7 次，  
* 6 出现了 8 次。

先将每个点数乘以它的频数，然后求和：

得分总和 =

\begin{align*}
&7 \times 1 + 8 \times 2 \\
&+ 6 \times 3 + 4 \times 4 \\
&+ 7 \times 5 + 8 \times6 \\
= &140
\end{align*}

总次数 =

\begin{align*}
&7 + 8 + 6 + 4 + 7 + 8 \\
= &40
\end{align*}

平均值为：

\[ \frac{140}{40} = 3.5 \]

所以，平均得分为 3.5。
"""#,
                ),
            ]
        ),
    ]
    
    static let trignometry: [ExerciseLevel] = [
        ExerciseLevel(
            id: "trignometry-chp-1",
            courseID: statID,
            courseSlug: statSlug,
            chapterID: "",
            chapterSlug: "central-meausres",
            title: "",
            index: 1,
            exercises: [
                Exercise(
                    id: "triangle-exercise-1",
                    levelId: "trignometry-chp-1",
                    prompts: [
                        .image("triangle-exercise-1"),
                        .text("这个图形叫作：")
                    ],
                    multipleChoice: MultipleChoice(
                        choices: [
                            "直角三角形",
                            "正三角形（等边三角形）",
                            "不规则三角形",
                            "矩形"
                        ],
                        correctIndex: 1
                    ),
                    explanation: #"""
这是三角形，因为它有三条边和三个角。

它是正三角形（等边三角形），因为它具有：

* 三条相等的边。
* 三个相等的角。
"""#,
                ),
                Exercise(
                    id: "triangle-exercise-5",
                    levelId: "trignometry-chp-1",
                    prompts: [
                        .image("triangle-exercise-5-a"),
                        .text("图中显示的是一个菱形。如果画出菱形的对角线，形成的四个三角形是：")
                    ],
                    multipleChoice: MultipleChoice(
                        choices: [
                            "等腰直角三角形",
                            "不等边直角三角形",
                            "等腰锐角三角形",
                            "不等边锐角三角形"
                        ],
                        correctIndex: 1
                    ),
                    explanation: #"""
菱形的对角线互相垂直，长度一般不相等：

![rhombus](triangle-exercise-5-b)

这样形成的四个三角形都是不等边直角三角形。

只有当这个菱形同时也是正方形时，这些三角形才会是等腰直角三角形（这是一种特殊情况）。
"""#,
                ),
            ]
        )
    ]
}
