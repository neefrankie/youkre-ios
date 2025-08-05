//
//  ExerciseData.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/14.
//

struct ExerciseData {
    static let solveEq = "解方程"
    static let opOrder = "算一算下式等于多少？注意运算顺序"
    
    static let allExercises: [CourseKind: [Exercise]] = [
        .calculus: ExerciseData.calculus,
        .algebra: ExerciseData.algebra,
        .probability: ExerciseData.stats,
        .trigonometry: ExerciseData.trigonometry,
    ]
    
    static let algebra = [
        Exercise(
            id: "algebra-introduction-1",
            course: .algebra,
            promptParts: [
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
            learnMore: ChapterLink.algebraIntro
        ),
        Exercise(
            id: "algebra-introduction-2",
            course: .algebra,
            promptParts: [
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
            learnMore: ChapterLink.algebraIntro
        ),
        Exercise(
            id: "algebra-introduction-3",
            course: .algebra,
            promptParts: [
                .text(solveEq),
                .latex("x - 3 = 8")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "5",
                    "12",
                    "8",
                    "11"
                ],
                correctIndex: 3
            ),
            explanation: #"""
    开始：

    \[ x - 3 = 8 \]

    等式两边都减去 5:

    \[ x - 3 + 3 = 8 + 3 \]

    算一下 -3 + 3 = 0，8 + 3 = 11，得到：

    \[ x + 0 = 11 \]

    解得：

    \[ x = 11 \]
    """#,
            learnMore: ChapterLink.algebraIntro
        ),
        Exercise(
            id: "algebra-introduction-4",
            course: .algebra,
            promptParts: [
                .text(solveEq),
                .latex("x - 8 = 7")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "1",
                    "15",
                    "-1",
                    "8"
                ],
                correctIndex: 1
            ),
            explanation: #"""
    开始：

    \[ x - 8 = 7 \]

    等式两边都加上 8:

    \[ x - 8 + 8 = 7 + 8 \]

    算一下 -8 + 8 = 0，7 + 8 = 15，得到：

    \[  x + 0 = 15 \]

    解得：

    \[ x = 15 \]
    """#,
            learnMore: ChapterLink.algebraIntro
        ),
        Exercise(
            id: "algebra-introduction-5",
            course: .algebra,
            promptParts: [
                .text(solveEq),
                .latex("y + 3 = 9")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "6",
                    "12",
                    "3",
                    "5"
                ],
                correctIndex: 0
            ),
            explanation: #"""
    开始：

    \[ y + 3 = 9 \]

    等式两边都减去 3:

    \[ y + 3 - 3 = 9 - 3 \]

    算一下 3 - 3 = 0，9 - 3 = 6，得到：

    \[  y + 0 = 6 \]

    解得：

    \[ y = 6 \]
    """#,
            learnMore: ChapterLink.algebraIntro
        ),
        Exercise(
            id: "algebra-introduction-6",
            course: .algebra,
            promptParts: [
                .text(solveEq),
                .latex("7 + y = 12")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "5",
                    "19",
                    "4",
                    "12",
                ],
                correctIndex: 0
            ),
            explanation: #"""
    开始：

    \[ 7 + y = 12 \]

    等式两边都减去 7:

    \[ 7 - 7 + y = 12 - 7 \]

    算一下 7 - 7 = 0，12 - 7 = 5，得到：

    \[  0 + y = 5 \]

    解得：

    \[ y = 5 \]
    """#,
            learnMore: ChapterLink.algebraIntro
        ),
        Exercise(
            id: "algebra-introduction-7",
            course: .algebra,
            promptParts: [
                .text(solveEq),
                .latex("y - 5 = 9")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "4",
                    "13",
                    "14",
                    "18"
                ],
                correctIndex: 2
            ),
            explanation: #"""
    开始：

    \[ y - 5 = 9 \]

    等式两边都减去 7:

    \[ y - 5 + 5 = 9 + 5 \]

    算一下 -5 + 5 = 0，9 + 5 = 14，得到：

    \[  y + 0 = 14 \]

    解得：

    \[ y = 14 \]
    """#,
            learnMore: ChapterLink.algebraIntro
        ),
        Exercise(
            id: "algebra-introduction-8",
            course: .algebra,
            promptParts: [
                .text(solveEq),
                .latex("10 - y = 6")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "16",
                    "5",
                    "4",
                    "9",
                ],
                correctIndex: 2
            ),
            
            explanation: #"""
    开始：

    \[ 10 - y = 6 \]

    等式两边都减去 10:

    \[ 10 - 10 - y = 6 - 10 \]

    算一下 10 - 10 = 0，6 - 10 = -4，得到：

    \[ 0 - y = -4 \]
    
    即：
    
    \[ -y = -4 \]

    解得：

    \[ y = 4 \]
    """#,
            learnMore: ChapterLink.algebraIntro
        ),
        Exercise(
            id: "algebra-introduction-9",
            course: .algebra,
            promptParts: [
                .text(solveEq),
                .latex(#"x + 2\frac{1}{2} = 10"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    #"x = 7\frac{1}{2}"#,
                    #"x = 8\frac{1}{2}"#,
                    #"x = 12\frac{1}{2}"#,
                    #"x = 13\frac{1}{2}"#
                ],
                correctIndex: 0,
                isLatex: true
            ),
            explanation: #"""
    开始：

    \[ x + 2\frac{1}{2} = 10 \]

    两边都减去 2½ :

    \[ x + 2\frac{1}{2} - 2\frac{1}{2} = 10 - 2\frac{1}{2} \]

    算一算:

    \begin{align*}
    2\frac{1}{2} - 2\frac{1}{2} &= 0 \\
    10 - 2\frac{1}{2} &= 7\frac{1}{2}
    \end{align*}

    得到:

    \[ x + 0 = 7\frac{1}{2} \]

    解得:

    \[ x = 7\frac{1}{2} \]
    """#,
            learnMore: ChapterLink.algebraIntro
        ),
        Exercise(
            id: "algebra-introduction-10",
            course: .algebra,
            promptParts: [
                .text(solveEq),
                .latex(#"9 - x = 3\frac{1}{2}"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    #"x = 12\frac{1}{2}"#,
                    #"x = 11\frac{1}{2}"#,
                    #"x = 6\frac{1}{2}"#,
                    #"x = 5\frac{1}{2}"#
                ],
                correctIndex: 3,
                isLatex: true
            ),
            explanation: #"""
    开始:

    \[ 9 - x = 3\frac{1}{2} \]

    两边都减去 9：

    \[ 9 - 9 - x = 3\frac{1}{2} - 9 \]

    计算后得:

    \[ 0 - x = -5\frac{1}{2} \]

    即：

    \[ -x = -5\frac{1}{2} \]

    解得:

    \[ x = 5\frac{1}{2} \]
    """#,
            learnMore: ChapterLink.algebraIntro
        ),
        
        // Algebra, Chapter 2
        Exercise(
            id: "algebra-introduction-multiply-1",
            course: .algebra,
            promptParts: [
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
            learnMore: ChapterLink.algebraMul
        ),
        Exercise(
            id: "algebra-introduction-multiply-2",
            course: .algebra,
            promptParts: [
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
            learnMore: ChapterLink.algebraMul
        ),
        Exercise(
            id: "algebra-introduction-multiply-3",
            course: .algebra,
            promptParts: [
                .text(solveEq),
                .latex(#"\frac{x}{2} = 3"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "6",
                    "9",
                    "4",
                    "12"
                ],
                correctIndex: 0
            ),
            explanation: #"""
开始:

\[ \frac{x}{2} = 3 \]

两边都乘以 2:

\[ \frac{x}{2} \times 2 = 3 \times 2 \]

算一算:

\[ \frac{1}{2} \times 2 = 1, 3 \times 2 = 6 \]

得到:

\[ 1x = 6 \]

解得:

\[ x = 6 \]    
"""#,
            learnMore: ChapterLink.algebraMul
        ),
        Exercise(
            id: "algebra-introduction-multiply-4",
            course: .algebra,
            promptParts: [
                .text(solveEq),
                .latex(#"\frac{x}{3} = 4"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "15",
                    "12",
                    "4",
                    "3"
                ], correctIndex: 1
            ),
            explanation: #"""
开始:

\[ \frac{x}{3} = 4 \]

两边都乘以 3:

\[ \frac{x}{3} \times 3 = 4 \times 3 \]

算一算:

\[ \frac{1}{3} \times 3 = 1, 4 \times 3 = 12 \]

得到:

\[ 1x = 12 \]

解得:

\[ x = 12 \]    
"""#,
            learnMore: ChapterLink.algebraMul
        ),
        Exercise(
            id: "algebra-introduction-multiply-5",
            course: .algebra,
            promptParts: [
                .text(solveEq),
                .latex(#"\frac{1}{5}x + 2 = 6"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "22",
                    "20",
                    "30",
                    "4"
                ],
                correctIndex: 1,
            ),
            explanation: #"""
开始:

\[ \frac{1}{5}x + 2 = 6 \]

两边都减去 2:

\[ \frac{1}{5}x + 2 - 2 = 6 - 2 \]

算一算 (2 - 2 = 0, 6 - 2 = 4) 得到:

\[ \frac{1}{5}x + 0 = 4 \]

解得:

\[ \frac{1}{5}x = 4 \]

两边都乘以 5:

\[ \frac{1}{5}x \times 5 = 4 \times 5 \]

算一算:

\begin{align*}
\frac{1}{5} \times 5 &= 1 \\
2 \times 5 &= 10
\end{align*}

得到:

\[ 1x = 20 \]

解得:

\[ x = 20 \]
"""#,
            learnMore: ChapterLink.algebraMul
        ),
        Exercise(
            id: "algebra-introduction-multiply-6",
            course: .algebra,
            promptParts: [
                .text(solveEq),
                .latex(#"3x - 2 = 7"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "5",
                    "9",
                    "3",
                    "6"
                ],
                correctIndex: 2
            ),
            explanation: #"""
开始:

\[ 3x - 2 = 7 \]

两边都加上 2:

\[ 3x - 2 + 2 = 7 + 2 \]

算一算 (-2 + 2 = 0, 7 + 2 = 9) 得到:

\[ 3x + 0 = 9 \]

解得:

\[ 3x = 9 \]

两边都除以 3:

\[ \frac{3x}{3} = \frac{9}{3} \]

算一算 (3/3 = 1, 9/3 = 3) 得到:

\[ 1x = 3 \]

解得:

\[ x = 3 \]
"""#,
            learnMore: ChapterLink.algebraMul
        ),
        Exercise(
            id: "algebra-introduction-multiply-7",
            course: .algebra,
            promptParts: [
                .text(solveEq),
                .latex(#"2x + 5 = 13"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "4",
                    "8",
                    "18",
                    "9"
                ],
                correctIndex: 0
            ),
            explanation: #"""
开始:

\[ 2x + 5 = 13 \]

两边都减去 5:

\[ 2x + 5 - 5 = 13 - 5 \]

算一算 (5 - 5 = 0, 13 - 5 = 8) 得到:

\[ 2x + 0 = 8 \]

解得:

\[ 2x = 8 \]

两边都除以 3:

\[ \frac{2x}{2} = 8/2 \]

算一算 (2/2 = 1，8/2 = 3) 得到:

\[ 1x = 4 \]

解得:

\[ x = 4 \]
"""#,
            learnMore: ChapterLink.algebraMul
        ),
        Exercise(
            id: "algebra-introduction-multiply-8",
            course: .algebra,
            promptParts: [
                .text(solveEq),
                .latex(#"5x - 1 = 19"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "20",
                    "4",
                    "18",
                    "3"
                ],
                correctIndex: 1
            ),
            explanation: #"""
开始:

\[ 5x - 1 = 19 \]

两边都加上 1:

\[ 5x - 1 + 1 = 19 + 1 \]

算一算 (-1 + 1 = 0, 19 + 1 = 20) 得到:

\[ 5x + 0 = 20 \]

解得:

\[ 5x = 20 \]

两边都除以 3:

\[ \frac{5x}{5} = 20/5 \]

算一算 (5 ÷ 5 = 1, 20 ÷ 5 = 4) 得到:

\[ 1x = 4 \]

解得:

\[ x = 4 \]
"""#,
            learnMore: ChapterLink.algebraMul
        ),
        Exercise(
            id: "algebra-introduction-multiply-9",
            course: .algebra,
            promptParts: [
                .text(solveEq),
                .latex(#"2(x + 3) = 10"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "5",
                    "4",
                    "2",
                    "8"
                ],
                correctIndex: 2
            ),
            explanation: #"""
开始:

\[ 2(x + 1) = 10 \]

两边都除以 2:

\[ \frac{2(x + 1)}{2} = \frac{10}{2} \]

算一算 (2/2 = 1, 10/2 = 5) 得到:

\[ x + 3 = 5 \]

两边都减去 3:

\[ x + 3 - 3 = 5 - 3 \]

算一算 (3 - 3 = 0，5 - 3 = 2) 得到:

\[ x + 0 = 2 \]

解得:

\[ x = 2 \]
"""#,
            learnMore: ChapterLink.algebraMul
        ),
        Exercise(
            id: "algebra-introduction-multiply-10",
            course: .algebra,
            promptParts: [
                .text(solveEq),
                .latex(#"\frac{1}{2}(y - 6) = 7"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "20",
                    "14",
                    "8",
                    "16"
                ],
                correctIndex: 0
            ),
            explanation: #"""
开始:

\[ \frac{1}{2}(y - 6) = 7 \]

两边都乘以 2:

\[ \frac{1}{2}(y - 6) \times 2 = 7 \times 2 \]

算一算 (1/2 x 2 = 1, 7 x 2 = 14) 得到:

\[ y - 6 = 14 \]

两边都加上 6:

\[ y - 6 + 6 = 14 + 6 \]

算一算 (-6 + 6 = 0, 14 + 6 = 20) 得到:

\[ y + 0 = 20 \]

解得:

\[ x = 20 \]
"""#,
            learnMore: ChapterLink.algebraMul
        ),
        
        
        // Algebra, Chapter 3
        Exercise(
            id: "operation-order-pemdas-exercise-1",
            course: .algebra,
            promptParts: [
                .text(opOrder),
                .latex(#"6 \div 3 + 4 \times 2"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "10",
                    "12",
                    "1",
                    "3"
                ],
                correctIndex: 0
            ),
            explanation: #"""
运算顺序是：

* 先算括号（如果有）  
* 然后是指数（幂、平方根等）  
* 接着是乘法和除法（从左到右）  
* 最后是加法和减法（从左到右）

所以我们先做除法和乘法，再做加法：

\begin{align*}
6 \div 3 = 2 \\
4 \times 2 = 8
\end{align*}

即：

\begin{align*}
&6 \div 3 + 4 \times 2 \\
= &2 + 8 \\
= &10
\end{align*}
"""#,
            learnMore: ChapterLink.algebraOpOrder
        ),
        Exercise(
            id: "operation-order-pemdas-exercise-2",
            course: .algebra,
            promptParts: [
                .text(opOrder),
                .latex(#"6 \times 4 - 12 \div 3 - 8"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "-4",
                    "4",
                    "12",
                    "20"
                ],
                correctIndex: 2
            ),
            explanation: #"""
运算顺序是：

* 先算括号（如果有）  
* 然后是指数（幂、平方根等）  
* 接着是乘法和除法（从左到右）  
* 最后是加法和减法（从左到右）

所以我们先做乘除，再做加减，乘除的优先级相同。

所以先做 6 x 4 和 12 ÷ 3，然后是减法：

\begin{align*}
&6 \times 4 - 12 \div 3 - 8 \\
= &24 - 12 \div 3 - 8 \\
= &24 - 4 - 8 \\
= &20 - 8 \\
= &12  
\end{align*}
"""#,
            learnMore: ChapterLink.algebraOpOrder
        ),
        Exercise(
            id: "operation-order-pemdas-exercise-3",
            course: .algebra,
            promptParts: [
                .text(opOrder),
                .latex(#"4 \times 4 - 3 \times 3 - 16 \div 4"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "5",
                    "2",
                    "4",
                    "3"
                ],
                correctIndex: 3
            ),
            explanation: #"""
运算顺序是：

* 先算括号（如果有）  
* 然后是指数（幂、平方根等）  
* 接着是乘法和除法（从左到右）  
* 最后是加法和减法（从左到右）

所以我们先做乘除（按照自左至右的顺序），再做加减（按照自左至右的顺序）：

\begin{align*}
&4 \times 4 - 3 \times 3 - 16 \div 4 \\
= &16 - 3 \times 3 - 16 \div 4 \\
= &16 - 9 - 16 \div 4 \\
= &16 - 9 - 4 \\
= &7 - 4 \\
= &3 
\end{align*}
"""#,
            learnMore: ChapterLink.algebraOpOrder
        ),
        Exercise(
            id: "operation-order-pemdas-exercise-4",
            course: .algebra,
            promptParts: [
                .text(opOrder),
                .latex(#"20 - (3 \times 2^3 - 5)"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "1",
                    "-11",
                    "19",
                    "2"
                ],
                correctIndex: 0
            ),
            explanation: #"""
运算顺序是：

* 先算括号（如果有）  
* 然后是指数（幂、平方根等）  
* 接着是乘法和除法（从左到右）  
* 最后是加法和减法（从左到右）

先从括号里面算起，括号里面则先算幂：

\begin{align*}
&20 - (3 \times 2^3 - 5) \\
= &20 - (3 \times 8 - 5)
\end{align*}


因为:

\[ 2^3 = 2 \times 2 \times 2 = 8 \]

而不是 

\[ 2 \times 3 = 6 \]

接下来是乘法：

\begin{align*}
&20 - (3 \times 8 - 5) \\
= &20 - (24 - 5)   
\end{align*}

然后是减法(还在括号里面):

\begin{align*}
&20 - (24 - 5) \\
= &20 - 19 \\
= &1
\end{align*}


现在括号里面的算完了，最后一步是减法：

\[ 20 - 19 = 1 \]

放在一起看：

\begin{align*}
&20 - (3 \times 2^3 - 5) \\
= &20 - (3 \times 8 - 5) \\
= &20 - (24 - 5) \\
= &20 - 19 \\
= &1  
\end{align*}
"""#,
            learnMore: ChapterLink.algebraOpOrder
        ),
        Exercise(
            id: "operation-order-pemdas-exercise-5",
            course: .algebra,
            promptParts: [
                .text(opOrder),
                .latex(#"(5 + 2)^2 - 9 \times 3 + 2^3"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "8",
                    "30",
                    "40",
                    "20"
                ],
                correctIndex: 1
            ),
            explanation: #"""
运算顺序是：

* 先算括号（如果有）  
* 然后是指数（幂、平方根等）  
* 接着是乘法和除法（从左到右）  
* 最后是加法和减法（从左到右）

先算括号里面：

\[ 5 + 2 = 7 \]

即：

\begin{align*}
&(5 + 2)^2 - 9 \times 3 + 2^3 \\
= &7^2 - 9 \times 3 + 2^3
\end{align*}


然后是幂：

\begin{align*}
7^2 &= 7 \times 7 \\
&= 49 \\
2^3 &= 2 \times 2 \times 2 \\
&= 8 
\end{align*}

因此：

\begin{align*}
&7^2 - 9 \times 3 + 2^3 \\
= &49 - 9 \times 3 + 8 
\end{align*}


接下来是乘法：

\[ 49 - 9 \times 3 + 8 = 49 - 27 + 8 \]

然后按照自左至右的顺序算加减：

\[ 49 - 27 + 8 = 22 + 8 = 30 \]

也就是:

\begin{align*}
&(5 + 2)^2 - 9 \times 3 + 2^3 \\
= &7^2 - 9 \times 3 + 2^3 \\
= &49 - 9 \times 3 + 8 \\
= &49 - 27 + 8 \\
= &22 + 8 \\
= &30  
\end{align*} 
"""#,
            learnMore: ChapterLink.algebraOpOrder
        ),
        Exercise(
            id: "operation-order-pemdas-exercise-6",
            course: .algebra,
            promptParts: [
                .text(opOrder),
                .latex(#"(12 \div 3 + 4) - (4^2 - 6 \times 2)"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "4",
                    "8",
                    "5",
                    "12"
                ],
                correctIndex: 0
            ),
            explanation: #"""
运算顺序是：

* 先算括号（如果有）  
* 然后是指数（幂、平方根等）  
* 接着是乘法和除法（从左到右）  
* 最后是加法和减法（从左到右）

先算出括号里面的数。这里有两对括号，一步一步来算。

第一对括号里面是：

\[ 12 \div 3 + 4 \]

先做除法：

\[ 12 \div 3 + 4 = 4 + 4 \]

然后是加法：

\[ 4 + 4 = 8 \]

第二对括号：

\[4^2 - 6 \times 2\]

先算幂：

\[ 4^2 - 6 \times 2 = 16 - 6 \times 2 \]

接下来是乘法：

\[ 16 - 6 \times 2 = 16 - 12 \]

然后是减法：

\[ 16 - 12 = 4 \]

现在两对括号里面都简化了，最后一步是减法：

\begin{align*}
&(12 \div 3 + 4) - (42 - 6 \times 2) \\
= &8 - 4 \\
= &4
\end{align*}

也就是：

\begin{align*}
&(12 \div 3 + 4) - (4^2 - 6 \times 2) \\
= &(4 + 4) - (4^2 - 6 \times 2) \\
= &8 - (4^2 - 6 \times 2) \\
= &8 - (16 - 6 \times 2) \\
= &8 - (16 - 12) \\
= &8 - 4 \\
= &4
\end{align*}
"""#,
            learnMore: ChapterLink.algebraOpOrder
        ),
        Exercise(
            id: "operation-order-pemdas-exercise-7",
            course: .algebra,
            promptParts: [
                .text(opOrder),
                .latex(#"(5^2 - 5) \div (4^2 + 8 - 7 \times 2)"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "20",
                    "7",
                    "2",
                    "4"
                ],
                correctIndex: 2
            ),
            explanation: #"""
运算顺序是：

* 先算括号（如果有）  
* 然后是指数（幂、平方根等）  
* 接着是乘法和除法（从左到右）  
* 最后是加法和减法（从左到右）

先算出括号里面的数。这里有两对括号，一步一步来算。

第一对括号：

\[ 5^2 - 5 \]

先算幂：

\[ 5^2 - 5 = 25 - 5 \]

再算减法：

\[ 25 - 5 = 20 \]

第二对括号：

\[ 4^2 + 8 - 7 \times 2 \]

先算幂：

\begin{align*}
&4^2 + 8 - 7 \times 2 \\
= &16 + 8 - 7 \times 2
\end{align*}

再算乘法：

\begin{align*}
&16 + 8 - 7 \times 2 \\
= &16 + 8 - 14
\end{align*}

然后按照自左至右的顺序算加减：

\begin{align*}
&16 + 8 - 14 \\
= &24 - 14 \\
= &10 
\end{align*}

现在括号里面简化了，最后一步是除法：

\begin{align*}
&(5^2 - 5) \div (4^2 + 8 - 7 \times 2) \\
= &20 \div 10 \\
= &2   
\end{align*}

也就是：

\begin{align*}
&(5^2 - 5) \div (42 + 8 - 7 \times 2) \\
= &(25 - 5) \div (16 + 8 - 7 \times 2) \\
= &(25 - 5) \div (16 + 8 - 14) \\
= &(25 - 5) \div (24 - 14) \\
= &20 \div 10 \\
= &2    
\end{align*} 
"""#,
            learnMore: ChapterLink.algebraOpOrder
        ),
        Exercise(
            id: "operation-order-pemdas-exercise-8",
            course: .algebra,
            promptParts: [
                .text(opOrder),
                .latex(#"(3^3 - \frac{9}{3}) + (4 \times 3 - 3^2)"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "27",
                    "6",
                    "24",
                    "20"
                ],
                correctIndex: 0
            ),
            explanation: #"""
运算顺序是：

* 先算括号（如果有）  
* 然后是指数（幂、平方根等）  
* 接着是乘法和除法（从左到右）  
* 最后是加法和减法（从左到右）

先算出括号里面的数。这里有两对括号，一步一步来算。

第一对括号里面是：

\[ 3^3 - \frac{9}{3} \]

先算幂：

\[ 3^3 - \frac{9}{3} = 27 - \frac{9}{3} \]

再算除法：

\[ 27 - \frac{9}{3} = 27 - 3 \]

最后是减法：

\[ 27 - 3 = 24 \]

第二对括号：

\[ 4 \times 3 - 3^2 \]

先算幂：

\[ 4 \times 3 - 3^2 = 4 \times 3 - 9 \]

然后是乘法

\[ 4 \times 3 - 9 = 12 - 9 \]

再做减法：

\[ 12 - 9 = 3 \]

现在括号里面简化了，最后一步是加法：

\begin{align*}
&(3^3 - \frac{9}{3}) + (4 \times 3 - 3^2) \\
= &24 + 3 \\
= &27  
\end{align*}

放在一起看看：

\begin{align*}
&(3^3 - \frac{9}{3}) + (4 \times 3 - 3^2) \\
= &(27 - \frac{9}{3}) + (4 \times 3 - 9) \\
= &(27 - 3) + (12 - 9) \\
= &24 + 3 \\
= &27
\end{align*}
"""#,
            learnMore: ChapterLink.algebraOpOrder
        ),
        Exercise(
            id: "operation-order-pemdas-exercise-9",
            course: .algebra,
            promptParts: [
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
            learnMore: ChapterLink.algebraOpOrder
        ),
        Exercise(
            id: "operation-order-pemdas-exercise-10",
            course: .algebra,
            promptParts: [
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
            learnMore: ChapterLink.algebraOpOrder
        ),
    ]
    
    // Statistics
    static let stats = [
        Exercise(
            id: "central-meausres-exercise-1",
            course: .probability,
            promptParts: [
                .text("在年终考试中，乔乔的成绩如下："),
                .table(
                    data: [
                        "科学", "34",
                        "英语", "90",
                        "历史", "87",
                        "数学", "34",
                        "地理", "55"
                    ],
                    layout: .rows(2)
                ),
                .text("乔乔的年终考试平均分是多少？")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "34",
                    "55",
                    "60",
                    "87"
                ],
                correctIndex: 2
            ),
            explanation: #"""
要计算平均分，步骤如下：

* 先把所有分数加起来，
* 然后除以分数的个数。

Joe 的总分是：

\[ 34 + 90 + 87 + 34 + 55 = 300 \]

一共考了 5 门，所以平均分为：

\[ 300 \div 5 = 60 \]

因此，乔乔的平均分是 60。
"""#,
            learnMore: ChapterLink.statsChp1Sec1
        ),
        Exercise(
            id: "central-meausres-exercise-2",
            course: .probability,
            promptParts: [
                .text("在年终考试中，乔乔的成绩如下："),
                .table(
                    data: [
                        "科学", "34",
                        "英语", "90",
                        "历史", "87",
                        "数学", "34",
                        "地理", "55"
                    ],
                    layout: .rows(2)
                ),
                .text("乔乔的成绩中位数是多少？")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "34",
                    "55",
                    "60",
                    "87"
                ],
                correctIndex: 1
            ),
            explanation: #"""
要找出中位数，首先要把分数从小到大排列：

* 科学 34  
* 数学 34  
* 地理 55  
* 历史 87  
* 英语 90  

中位数是中间的那个数，也就是 55。
"""#,
            learnMore: ChapterLink.statsChp1Sec1
        ),
        Exercise(
            id: "central-meausres-exercise-3",
            course: .probability,
            promptParts: [
                .text("在年终考试中，乔乔的成绩如下："),
                .table(
                    data: [
                        "科学", "34",
                        "英语", "90",
                        "历史", "87",
                        "数学", "34",
                        "地理", "55"
                    ],
                    layout: .rows(2)
                ),
                .text("乔乔的成绩众数是多少？")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "34",
                    "55",
                    "60",
                    "87"
                ],
                correctIndex: 0
            ),
            explanation: #"""
众数是指出现次数最多的那个分数。

在这组成绩中，34 出现了两次（科学和数学），其他分数都只出现了一次。

所以，众数是 34。
"""#,
            learnMore: ChapterLink.statsChp1Sec1
        ),
        Exercise(
            id: "central-meausres-exercise-4",
            course: .probability,
            promptParts: [
                .text("下表显示了北京每个月的平均气温："),
                .table(
                    data: [
                        "1月", "1",
                        "2月", "5",
                        "3月", "11",
                        "4月", "20",
                        "5月", "26",
                        "6月", "30",
                        "7月", "30",
                        "8月", "29",
                        "9月", "25",
                        "10月", "19",
                        "11月", "10",
                        "12月", "3",
                    ],
                    layout: .rows(2)
                ),
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
            learnMore: ChapterLink.statsChp1Sec1
        ),
        Exercise(
            id: "central-meausres-exercise-5",
            course: .probability,
            promptParts: [
                .text("下表显示了北京每个月的平均气温："),
                .table(
                    data: [
                        "1月", "1",
                        "2月", "5",
                        "3月", "11",
                        "4月", "20",
                        "5月", "26",
                        "6月", "30",
                        "7月", "30",
                        "8月", "29",
                        "9月", "25",
                        "10月", "19",
                        "11月", "10",
                        "12月", "3",
                    ],
                    layout: .rows(2)
                ),
                .text("这些气温的中位数是多少？")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "19.5°C",
                    "17.4°C",
                    "20°C",
                    "30°C"
                ],
                correctIndex: 0
            ),
            explanation: #"""
中位数是“中间”的数值。

首先将气温从小到大排列：

1, 3, 5, 10, 11, 19, 20, 25, 26, 29, 30, 30

因为一共有 12 个数（偶数个），中间的两个数是 19°C 和 20°C。

中位数就是这两个数的平均值：

\begin{align*}
&\frac{19 + 20}{2} \\
&= \frac{39}{2} \\
&= 19.5
\end{align*}

所以，中位数是 19.5°C。
"""#,
            learnMore: ChapterLink.statsChp1Sec1
        ),
        Exercise(
            id: "central-meausres-exercise-6",
            course: .probability,
            promptParts: [
                .text("下表显示了北京每个月的平均气温："),
                .table(
                    data: [
                        "1月", "1",
                        "2月", "5",
                        "3月", "11",
                        "4月", "20",
                        "5月", "26",
                        "6月", "30",
                        "7月", "30",
                        "8月", "29",
                        "9月", "25",
                        "10月", "19",
                        "11月", "10",
                        "12月", "3",
                    ],
                    layout: .rows(2)
                ),
                .text("这些气温的众数是多少？")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "19.5°C",
                    "17.4°C",
                    "20°C",
                    "30°C"
                ],
                correctIndex: 3
            ),
            explanation: #"""
众数是指出现次数最多的那个数值。

在这组气温中，30°C 出现了两次（在六月和七月），其他温度都只出现了一次。

所以，众数是 30°C。
"""#,
            learnMore: ChapterLink.statsChp1Sec1
        ),
        Exercise(
            id: "central-meausres-exercise-7",
            course: .probability,
            promptParts: [
                .text("小艾掷骰子多次，并将结果用柱状图表示出来，如下所示："),
                .image(name: "central-meausres-exercise-7"),
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
            learnMore: ChapterLink.statsChp1Sec1
        ),
        Exercise(
            id: "central-meausres-exercise-8",
            course: .probability,
            promptParts: [
                .text("小艾掷骰子多次，并将结果用柱状图表示出来，如下所示："),
                .image(name: "central-meausres-exercise-7"),
                .text("中位数得分是多少？")

            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "3",
                    "3.5",
                    "4",
                    "6.67"
                ],
                correctIndex: 0
            ),
            explanation: #"""
根据图表，各点数出现的次数为：

* 1 出现了 7 次，  
* 2 出现了 8 次，  
* 3 出现了 6 次，  
* 4 出现了 4 次，  
* 5 出现了 7 次，  
* 6 出现了 8 次。

总共有 40 个结果。因为是偶数个数据，所以中位数是中间两个数的平均值。

将所有数据从小到大排列后，第 20 和第 21 个数都是 3。

因此，中位数是：

\begin{align*}
&\frac{3 + 3}{2} \\
= &\frac{6}{2} \\
= &3
\end{align*}

所以，中位数得分为 3。
"""#,
            learnMore: ChapterLink.statsChp1Sec1
        ),
        Exercise(
            id: "central-meausres-exercise-9",
            course: .probability,
            promptParts: [
                .text("小艾掷骰子多次，并将结果用柱状图表示出来，如下所示："),
                .image(name: "central-meausres-exercise-7"),
                .text("众数是什么？")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "没有众数",
                    "众数是 4",
                    "有两个众数：2 和 6",
                    "众数是 8"
                ],
                correctIndex: 2
            ),
            explanation: #"""
根据图表，各点数出现的次数为：

* 1 出现了 7 次，
* 2 出现了 8 次，
* 3 出现了 6 次，
* 4 出现了 4 次，
* 5 出现了 7 次，
* 6 出现了 8 次。

其中，2 和 6 都出现了 8 次，是出现次数最多的两个数（也是柱状图中最长的两个条形）。

因此，这组数据有两个众数：2 和 6。
"""#,
            learnMore: ChapterLink.statsChp1Sec1
        ),
    ]
    
    // Trigonometry, Chapter 1
    static let trigonometry = [
        Exercise(
            id: "triangle-exercise-1",
            course: .trigonometry,
            promptParts: [
                .image(name: "triangle-exercise-1"),
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
            learnMore: ChapterLink.trigChp1Sec1
        ),
        Exercise(
            id: "triangle-exercise-3",
            course: .trigonometry,
            promptParts: [
                .image(name: "triangle-exercise-3"),
                .text("下面哪一项正确描述了这个三角形？")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "这是一个直角等腰三角形",
                    "这是一个锐角等腰三角形",
                    "这是一个钝角等腰三角形",
                    "这是一个钝角不等边三角形"
                ],
                correctIndex: 2
            ),
            explanation: #"""
这个三角形有两条边相等：AB = BC = 6，因此它是等腰三角形。

角 B 是一个钝角。

所以它是一个钝角等腰三角形。
"""#,
            learnMore: ChapterLink.trigChp1Sec1
        ),
        Exercise(
            id: "triangle-exercise-4",
            course: .trigonometry,
            promptParts: [
                .text("下面哪一项是不可能存在的？")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "钝角等腰三角形",
                    "锐角等腰三角形",
                    "钝角等边三角形",
                    "锐角等边三角形"
                ],
                correctIndex: 2
            ),
            explanation: #"""
钝角三角形有一个大于 90° 的角。

锐角三角形所有角都小于 90°。

钝角等腰三角形是可能的，例如：30°, 30° 和 120°。

锐角等腰三角形也是可能的，例如：50°, 50° 和 80°。

钝角等边三角形是不可能的，因为等边三角形的三个角都是 60°，都不可能是钝角。  

事实上，等边三角形本身就是锐角三角形，因为它的三个角都是 60°。

所以，唯一不可能存在的是钝角等边三角形。
"""#,
            learnMore: ChapterLink.trigChp1Sec1
        ),
        Exercise(
            id: "triangle-exercise-5",
            course: .trigonometry,
            promptParts: [
                .image(name: "triangle-exercise-5-a"),
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
            learnMore: ChapterLink.trigChp1Sec1
        ),
        Exercise(
            id: "triangle-exercise-6",
            course: .trigonometry,
            promptParts: [
                .image(name: "triangle-exercise-6"),
                .text("三角形 PQR 的面积是多少？")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "37.5",
                    "38.5",
                    "49",
                    "84"
                ],
                correctIndex: 1
            ),
            explanation: #"""
三角形的面积公式是：

\[ A = \frac{1}{2} \times b \times h \]

在这个三角形中，底边长度 b = 8 + 3 = 11，高 h = 7。

因此，三角形的面积为：

\begin{align*}
PQR &= \frac{1}{2} \times 11 \times 7 \\
&= 38.5
\end{align*}
"""#,
            learnMore: ChapterLink.trigChp1Sec1
        ),
        Exercise(
            id: "triangle-exercise-7",
            course: .trigonometry,
            promptParts: [
                .image(name: "triangle-exercise-7"),
                .text("三角形 ABC 的面积是多少？")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "17.4",
                    "18",
                    "21.75",
                    "27"
                ],
                correctIndex: 0
            ),
            explanation: #"""
这个三角形的底边是 BC，长度为 6 个单位，高是垂直高度 5.8 个单位。

三角形的面积公式是：

\[ A = \frac{1}{2} \times b \times h \]

在这个例子中，底边 b = 6，高 h = 5.8。

所以面积是：

\begin{align*}
&\frac{1}{2} \times 6 \times 5.8 \\
= &17.4
\end{align*}
"""#,
            learnMore: ChapterLink.trigChp1Sec1
        ),
        Exercise(
            id: "triangle-exercise-8",
            course: .trigonometry,
            promptParts: [
                .image(name: "triangle-exercise-8"),
                .text("三角形的面积是 42，它的高是多少？")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "5",
                    "6",
                    "7",
                    "9"
                ],
                correctIndex: 2
            ),
            explanation: #"""
三角形的面积公式是：

\[ A = \frac{1}{2}bh \]

其中，底边 b = 12，面积 A = 42。

代入公式得：

\begin{align*}
42 &= \frac{1}{2} \times 12 \times h \\
42 &= 6 \times h \\
6 \times h &= 42 \\
h &= 42 \div 6 = 7
\end{align*}
"""#,
            learnMore: ChapterLink.trigChp1Sec1
        ),
        Exercise(
            id: "triangle-exercise-9",
            course: .trigonometry,
            promptParts: [
                .image(name: "triangle-exercise-9"),
                .text("三角形的面积是 22.5，它的底边长度是多少？")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "5",
                    "7",
                    "8",
                    "9"
                ],
                correctIndex: 3
            ),
            explanation: #"""
三角形的面积公式是：

$$ A = \frac{1}{2}bh $$

其中，面积 A = 22.5，高 h = 5。

代入公式得：

\[ 22.5 = \frac{1}{2} \times b \times 5 \]

两边同时乘以 2：

\begin{align*}
45 &= b \times 5 \\
b &= 45 \div 5 \\
&= 9
\end{align*}
"""#,
            learnMore: ChapterLink.trigChp1Sec1
        ),
        Exercise(
            id: "triangle-exercise-10",
            course: .trigonometry,
            promptParts: [
                .image(name: "triangle-exercise-10"),
                .text("未知角 a° 的度数是多少？")
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    "53.6",
                    "71.8",
                    "72.7",
                    "143.6"
                ],
                correctIndex: 1
            ),
            explanation: #"""
这个三角形有两条边相等（长度为 6 个单位），所以它是等腰三角形。因此，标为 a° 的两个角也相等。

三角形的三个内角之和为 180°，所以：

\[ 36.4^\circ + a^\circ + a^\circ = 180^\circ \]

化简得：

\[ 36.4 + 2a = 180 \]

移项得：

\[ 2a = 180 - 36.4 = 143.6 \]

两边同时除以 2：

\[ a = 143.6 \div 2 = 71.8 \]
"""#,
            learnMore: ChapterLink.trigChp1Sec1
        ),
    ]
    
    // Calculus made easy
    static let calculus = [
        Exercise(
            id: "cme-1-a",
            course: .calculus,
            promptParts: [
                .text("𝑑𝑥 在微积分中表示什么？")
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
            learnMore: ChapterLink.cme1
        ),
        Exercise(
            id: "cme-1-b",
            course: .calculus,
            promptParts: [
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
            learnMore: ChapterLink.cme1
        ),
        Exercise(
            id: "cme-3-a",
            course: .calculus,
            promptParts: [
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
            learnMore: ChapterLink.cme3
        ),
        Exercise(
            id: "cme-3-b",
            course: .calculus,
            promptParts: [
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
            learnMore: ChapterLink.cme3
        ),
        Exercise(
            id: "cme-4-a",
            course: .calculus,
            promptParts: [
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
            learnMore: ChapterLink.cme4a
        ),
        Exercise(
            id: "cme-4-1",
            course: .calculus,
            promptParts: [
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
            learnMore: ChapterLink.cme4b
        ),
        Exercise(
            id: "cme-4-2",
            course: .calculus,
            promptParts: [
                .text("求以下函数的导数："),
                .latex(#"y = x^{-\frac{3}{2}}"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    #"-\frac{3}{2}x^{-\frac{1}{2}}"#,
                    #"\frac{3}{2}x^{-\frac{5}{2}}"#,
                    #"-\frac{5}{2}x^{-\frac{3}{2}}"#,
                    #"-\frac{3}{2}x^{-\frac{5}{2}}"#
                ],
                correctIndex: 3,
                isLatex: true
            ),
            explanation: #"""
使用幂函数求导公式：

$$
\frac{d}{dx}x^a = ax^{a-1}
$$

这里 a = -3/2，所以：

\begin{align*}
&\frac{d}{dx}x^{-\frac{3}{2}} \\
= &-\frac{3}{2}x^{-\frac{3}{2} - 1} \\
= &-\frac{3}{2}x^{-\frac{5}{2}}
\end{align*}
"""#,
            learnMore: ChapterLink.cme4a
        ),
        Exercise(
            id: "cme-4-3",
            course: .calculus,
            promptParts: [
                .text("求以下函数的导数："),
                .latex(#"y = x^{2a}"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    #"2a x^{2a}"#,
                    #"2a x^{2a-1}"#,
                    #"a x^{2a - 1}"#,
                    #"2 x^{2a - 1}"#
                ],
                correctIndex: 1,
                isLatex: true
            ),
            explanation: #"""
根据幂函数的求导法则：

$$
\frac{d}{dx}x^n = nx^{n-1}
$$

在本题中，指数是 n = 2a，所以：

$$
\frac{d}{dx}x^{2a} = 2a x^{2a-1}
$$
"""#,
            learnMore: ChapterLink.cme4a
        ),
        Exercise(
            id: "cme-4-4",
            course: .calculus,
            promptParts: [
                .text("求以下函数的导数："),
                .latex(#"u = t^{2.4}"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    #"2.4t^{1.4}"#,
                    #"2.4t^{3.4}"#,
                    #"1.4t^{1.4}"#,
                    #"2.4t^{-0.6}"#
                ],
                correctIndex: 0,
                isLatex: true
            ),
            explanation: #"""
根据幂函数的求导法则：

若 

$$
u = t^n
$$

则导数为 

$$
\frac{du}{dt} = n t^{n - 1}
$$

本题中 n = 2.4，所以：

\begin{align*}
&\frac{du}{dt} \\
= &2.4 t^{2.4 - 1} \\
= &2.4 t^{1.4} 
\end{align*}
"""#,
            learnMore: ChapterLink.cme4a
        ),
        Exercise(
            id: "cme-4-5",
            course: .calculus,
            promptParts: [
                .text("求以下函数的导数："),
                .latex(#"z = \sqrt[3]{u}"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    #"\frac{1}{3} u^{-\frac{1}{3}}"#,
                    #"\frac{1}{3}u^{-\frac{2}{3}}"#,
                    #"3u^{-\frac{2}{3}}"#,
                    #"-\frac{1}{3} u^{-\frac{2}{3}}"#
                ],
                correctIndex: 1,
                isLatex: true
            ),
            explanation: #"""
首先写成幂函数的形式：

$$
z = u^{\frac{1}{3}}
$$

根据幂函数求导法则：

若 

$$
z = u^n
$$

则导数为 

$$
\frac{dz}{du} = n u^{n - 1} 
$$

本题中 n = 1/3，所以：

\begin{align*}
&\frac{dz}{du} \\
= &\frac{1}{3} u^{\frac{1}{3} - 1} \\
= &\frac{1}{3} u^{-\frac{2}{3}}
\end{align*}
"""#,
            learnMore: ChapterLink.cme4a
        ),
        Exercise(
            id: "cme-4-6",
            course: .calculus,
            promptParts: [
                .text("求以下函数的导数："),
                .latex(#"y = \sqrt[3]{x^{-5}}"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    #"-\frac{5}{3}x^{-\frac{2}{3}}"#,
                    #"\frac{5}{3}x^{\frac{2}{3}}"#,
                    #"-\frac{3}{5}x^{-\frac{8}{5}}"#,
                    #"-\frac{5}{3}x^{-\frac{8}{3}}"#
                ],
                correctIndex: 3,
                isLatex: true
            ),
            explanation: #"""
首先将根号表示转换为指数形式：

\begin{align*}
y &= \sqrt[3]{x^{-5}} \\
&= (x^{-5})^{\frac{1}{3}} \\
&= x^{-\frac{5}{3}}  
\end{align*}

然后使用幂函数求导法则：

$$
\frac{d}{dx}x^a = ax^{a-1}
$$

这里 a = -5/3，所以：

\begin{align*}
&\frac{dy}{dx} \\
= &-\frac{5}{3}x^{-\frac{5}{3} - 1} \\
= &-\frac{5}{3}x^{-\frac{8}{3}}    
\end{align*}
"""#,
            learnMore: ChapterLink.cme4a
        ),
        Exercise(
            id: "cme-4-7",
            course: .calculus,
            promptParts: [
                .text("求以下函数的导数："),
                .latex(#"u = \sqrt[5]{\frac{1}{x^8}}"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    #"-\frac{8}{5}x^{-\frac{8}{5}}"#,
                    #"\frac{8}{5}x^{-\frac{8}{5}}"#,
                    #"-\frac{8}{5}x^{-\frac{13}{5}}"#,
                    #"\frac{8}{5}x^{-\frac{13}{5}}"#
                ],
                correctIndex: 2,
                isLatex: true
            ),
            explanation: #"""
首先将表达式转换为幂函数形式：

\begin{align*}
u &= \sqrt[5]{\frac{1}{x^8}} \\
&= \left(x^{-8}\right)^{\frac{1}{5}} \\
&= x^{-\frac{8}{5}}
\end{align*}


根据幂法则：

$$
\frac{d}{dx}x^a = ax^{a-1}
$$

这里 a = -8/5，所以：

\begin{align*}
\frac{du}{dx} &= \frac{d}{dx} \left( x^{-\frac{8}{5}} \right) \\
&= -\frac{8}{5}x^{-\frac{8}{5} - 1} \\
&= -\frac{8}{5}x^{-\frac{13}{5}} 
\end{align*}
"""#,
            learnMore: ChapterLink.cme4a
        ),
        Exercise(
            id: "cme-4-8",
            course: .calculus,
            promptParts: [
                .text("求以下函数的导数："),
                .latex(#"y = 2x^a"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    #"2ax^{a-1}"#,
                    #"2a x^{a}"#,
                    #"2 x^{a - 1}"#,
                    #"a x^{a - 1}"#
                ],
                correctIndex: 0,
                isLatex: true
            ),
            explanation: #"""
根据幂函数的求导法则，若：

$$
y = c x^n
$$

其中 c 是常数，则导数为：

$$
\frac{dy}{dx} = c \cdot n \cdot x^{n - 1}
$$

本题中 c = 2，指数 n = a，所以：

$$
\frac{dy}{dx} = 2a x^{a - 1}
$$
"""#,
            learnMore: ChapterLink.cme4b
        ),
        Exercise(
            id: "cme-4-9",
            course: .calculus,
            promptParts: [
                .text("求以下函数的导数："),
                .latex(#"y = \sqrt[q]{x^3}"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    #"\frac{3}{q}x^{3 - q}"#,
                    #"3x^{2}"#,
                    #"\frac{3}{q}{x^\frac{3-q}{3}}"#,
                    #"\frac{3}{q}x^{\frac{3}{q}}"#
                ],
                correctIndex: 2,
                isLatex: true
            ),
            explanation: #"""
首先将根号表达式转换为幂函数形式：

\begin{align*}
y &= \sqrt[q]{x^3} \\
&= x^{\frac{3}{q}}
\end{align*}

然后使用幂函数求导法则：

\begin{align*}
\frac{dy}{dx} &= \frac{d}{dx} \left( x^{\frac{3}{q}} \right) \\
&= \frac{3}{q}x^{\frac{3}{q} - 1} 
\end{align*}
"""#,
            learnMore: ChapterLink.cme4a
        ),
        Exercise(
            id: "cme-4-10",
            course: .calculus,
            promptParts: [
                .text("求以下函数的导数："),
                .latex(#"y = \sqrt[n]{\frac{1}{x^m}}"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    #"\frac{m}{n}x^{-\frac{m}{n} - 1}"#,
                    #"-\frac{m}{n}{x^{-\frac{m+n}{n}}}"#,
                    #"-\frac{m}{n}x^{-\frac{m + 1}{n}}"#,
                    #"-\frac{m}{n}x^{-\frac{m}{n}}"#
                ],
                correctIndex: 1,
                isLatex: true
            ),
            explanation: #"""
首先将表达式转换为幂函数形式：

\begin{align*}
y &= \sqrt[n]{\frac{1}{x^m}} \\
&= \left(x^{-m}\right)^{\frac{1}{n}} \\
&= x^{-\frac{m}{n}} 
\end{align*}


然后使用幂函数求导法则：

\begin{align*}
\frac{dy}{dx} &= \frac{d}{dx} \left( x^{-\frac{m}{n}} \right) \\
&= -\frac{m}{n}x^{-\frac{m}{n} - 1}   
\end{align*}
"""#,
            learnMore: ChapterLink.cme4a
        ),
//        Exercise(
//            id: "cal-6",
//            course: .calculus,
//            type: .multipleChoice,
//            difficulty: .intermediate,
//            promptParts: [
//                .text("以下函数的导数是什么？"),
//                .latex(#"ln(x)"#)
//            ],
//            fillInAnswer: nil,
//            multipleChoice: MultipleChoice(
//                choices: [
//                    #"\frac{1}{x}"#,
//                    #"x"#,
//                    #"e^x"#,
//                    #"x\cdot ln(x)"#
//                ],
//                correctIndex: 0,
//                isLatex: true
//            ),
//            explanation: "By definition, the derivative of ln(x) is 1/x.",
//            learnMore: ChapterLink.calChp4
//        ),
    ]
}
