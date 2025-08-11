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
