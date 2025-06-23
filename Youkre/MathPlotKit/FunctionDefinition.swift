//
//  FunctionDefinition.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/18.
//
import SwiftUI

enum FunctionCategory: String {
    case linear
    case polynomial
    case exponential
    case logarithmic
    case trigonometric
    case hyperbolic
    case rational
    case constant
    case composite
    case piecewise
}

struct FunctionDefinition: Identifiable, Equatable {
    let id: String
    let slug: String
    let name: String
    let category: FunctionCategory
    
    let title: String // Uncode version the function
    let latex: String // e.g., "f(x) = x^2"
    let derivativeLatex: String // e.g., "f'(x) = 2x"
    let integralLatex: String // // e.g., "\\int x^2 dx = \\frac{1}{3}x^3"
    
    let function: MathFunction?
    let bounds: (Double, Double)
    let image: String?
    
    
    init(
        id: String? = nil,
        slug: String,
        name: String,
        category: FunctionCategory,
        title: String,
        latex: String,
        derivativeLatex: String,
        integralLatex: String,
        function: MathFunction?,
        bounds: (Double, Double) = (-5, 5),
        image: String? = nil,
    ) {
        self.id = id ?? FunctionDefinition.slugify(slug)
        self.slug = slug
        self.name = name
        self.category = category
        self.title = title
        self.latex = latex
        self.derivativeLatex = derivativeLatex
        self.integralLatex = integralLatex
        self.bounds = bounds
        self.function = function
        self.image = image
    }
    
    private static func slugify(_ text: String) -> String {
        text
            .lowercased()
            .replacingOccurrences(
                of: "[^a-z0-9]",
                with: "-",
                options: .regularExpression,
            )
            .trimmingCharacters(in: CharacterSet(charactersIn: "-"))
    }
    
    static func == (lhs: FunctionDefinition, rhs: FunctionDefinition) -> Bool {
        return lhs.id == rhs.id
    }
    
    static let standardForm: [FunctionDefinition] = [
        // 0
        FunctionDefinition(
            slug: "quandratic",
            name: "二次函数",
            category: .polynomial,
            title: "y = x²",
            latex: "y = x^2",
            derivativeLatex: """
\\[ \\frac{d}{dx} x^2 = 2x \\]
""",
            integralLatex: """
\\[ \\int x^2\\, dx = \\frac{1}{3}x^3 + C \\]
""",
            function: QuadraticFunction(),
        ),
        // 1
        FunctionDefinition(
            slug: "reciprocal",
            name: "倒数函数", // Reciprocal Function，反比例函数
            category: .rational,
            title: "y = x-¹",
            latex: "y = \\frac{1}{x}",
            derivativeLatex: """
\\[ \\frac{d}{dx} \\frac{1}{x}  = -\\frac{1}{x^2} \\]

其中 𝑥 ≠ 0.             
""",
            integralLatex: """
\\[ \\int \\frac{1}{x}\\, dx = \\ln|x| + C \\]

其中 𝑥 ≠ 0.
""",
            function: ReciprocalFunction(),
        ),
        // 2
        FunctionDefinition(
            slug: "linear", // identity, y-equals-x
            name: "线性函数", // Linear Function
            category: .linear,
            title: "y = x",
            latex: "y = x",
            derivativeLatex: """
\\[ \\frac{d}{dx} x = 1 \\]
""",
            integralLatex: """
\\[ \\int x\\, dx = \\frac{1}{2} x^2 + C \\]             
""",
            function: LinearFunction(
                coefficient: 2, offset: 1
            ),
        ),
        // 3
        FunctionDefinition(
            slug: "constant",
            name: "常数", // Constant Function
            category: .constant,
            title: "y = a",
            latex: "y = a",
            derivativeLatex: """
\\[ \\frac{d}{dx} a = 0 \\]
""",
            integralLatex: """
\\[ \\int a\\, dx = ax + C \\]
""",
            function: ConstantFunction(),
        ),
        // 4
        FunctionDefinition(
            slug: "power-rule",
            name: "幂法则", // Power Function
            category: .polynomial,
            title: "y = xⁿ",
            latex: "y = x^n",
            derivativeLatex: """
### 幂法则

\\[ \\frac{d}{dx} x^n = nx^{n-1} \\]
""",
            integralLatex: """
\\[ \\int x^n\\, dx = \\frac{1}{n+1} x^{n+1} + C \\]

其中 𝑛 ≠ -1
""",
            function: nil,
        ),
        // 5
        FunctionDefinition(
            slug: "sum-rule",
            name: "加减法则", // Sum of Three Functions
            category: .composite,
            title: "y = u ± v",
            latex: "y = u + v",
            derivativeLatex: """
如果 𝑦 = 𝑢(𝑥) + 𝑣(𝑥)，则

\\[ \\frac{d}{dx}(u + v) = \\frac{du}{dx} + \\frac{dv}{dx} \\]
""",
            integralLatex: """
\\[ &\\int (u + v)\\, dx \\\\= &\\int u\\, dx + \\int v\\, dx \\]           
""",
            function: nil,
        ),
        // 6
        FunctionDefinition(
            slug: "product-rule",
            name: "乘积法则", // Product Rule Function
            category: .composite,
            title: "y = uv",
            latex: "y = uv",
            // TODO: image
            derivativeLatex: """
### 乘积法则

如果 𝑦 = 𝑢(𝑥)𝑣(𝑥)，则

\\[ \\frac{d}{dx} uv = u\\, \\frac{dv}{dx} + v\\, \\frac{du}{dx} \\]
""",
            integralLatex: "没有已知的通用公式",
            function: nil,
            image: "product-rule"
        ),
        // 7
        FunctionDefinition(
            slug: "quotient-rule",
            name: "商法则", // Quotient Rule Function
            category: .composite,
            title: "y = u/v",
            latex: "y = \\frac{u}{v}",
            // TODO: image
            derivativeLatex: """
### 商法则

如果 𝑦 = 𝑢(𝑥) / 𝑣(𝑥)，则

\\[ \\frac{dy}{dx} = \\frac{v\\, \\frac{du}{dx} - u\\, \\frac{dv}{dx}}{v^2} \\]
""",
            integralLatex: "没有已知的通用公式",
            function: nil,
        ),
        // 8
        FunctionDefinition(
            slug: "chain-rule",
            name: "链式法则", // Chain Rule
            category: .composite,
            title: "y = u",
            latex: "y = u",
            // TODO: text description
            derivativeLatex: """
### 链式法则

如果 𝑦 = 𝑓(𝑢(𝑥))，则

\\[ \\frac{dy}{dx} = \\frac{dy}{du} \\frac{du}{dx} \\]                
""",
            integralLatex: "没有已知的通用公式",
            function: nil,
        ),
        // 9
        FunctionDefinition(
            slug: "log-natural",
            name: "自然对数", // Natural Logarithm
            category: .logarithmic,
            title: "y = ln(x)",
            latex: "y = \\ln(x)",
            derivativeLatex: """
\\[ \\frac{d}{dx} \\ln(x) = \\frac{1}{x} \\]

其中 𝑥 > 0.               
""",
            integralLatex: """
\\[ \\int \\ln(x)\\, dx =  x(\\ln x - 1) + C \\]                
""",
            function: LogNatural(),
            bounds: (0.01, 5)
        ),
        // 10
        FunctionDefinition(
            slug: "log-base10",
            name: "常用对数", // Common Logarithm
            category: .logarithmic,
            title: "y = log₁₀(x)",
            latex: "y = \\log_{10}(x)",
            derivativeLatex: """
\\[ \\frac{d}{dx} \\log_{10}(x) = \\frac{1}{x ln(10)} \\]

其中 𝑥 > 0.               
""",
            integralLatex: """
\\[ \\int \\log_{10}(x)\\, dx = \\frac{x (\\ln(x) - 1)}{ln(10)}  + C \\]                
""",
            function: LogBase10Function(),
            bounds: (0.01, 5)
        ),
        // 11
        FunctionDefinition(
            slug: "exp-base-b",
            name: "指数函数", // Exponential Base a
            category: .exponential,
            title: "y = bˣ",
            latex: "y = b^x",
            derivativeLatex: """
\\[ \\frac{d}{dx}(b^x) = b^x \\ln(b) \\]

其中 𝑏 > 0 且 𝑏 ≠ 1.                
""",
            integralLatex: """
\\[ \\int b^x\\, dx = \\frac{b^x}{\\ln b} + C \\]

其中 𝑏 > 0 且 𝑏 ≠ 1.              
""",
            function: ExponentBaseB(),
            bounds: (-5, 3),
        ),
        // 12
        FunctionDefinition(
            slug: "exponent",
            name: "自然指数", // Exponential Function
            category: .exponential,
            title: "y = eˣ",
            latex: "y = e^x",
            derivativeLatex: """
\\[ \\frac{d}{dx} e^x = e^x \\]                
""",
            integralLatex: """
\\[ \\int e^x\\, dx = e^x + C \\]                
""",
            function: ExponentNatural(),
            bounds: (-5, 3),
        ),
        // 13
        FunctionDefinition(
            slug: "sine",
            name: "正弦函数", // Sine Function
            category: .trigonometric,
            title: "y = sin(x)",
            latex: "y = \\sin(x)",
            derivativeLatex: """
\\[ \\frac{d}{dx} \\sin(x) = \\cos(x) \\]                
""",
            integralLatex: """
\\[ \\int \\sin(x)\\, dx = -\\cos(x) + C \\]                
""",
            function: SineFunction(),
            bounds: (-2 * .pi, 2 * .pi),
        ),
        // 14
        FunctionDefinition(
            slug: "cosine",
            name: "余弦函数", // Cosine Function
            category: .trigonometric,
            title: "y = cos(x)",
            latex: "y = \\cos(x)",
            derivativeLatex: """
\\[ \\frac{d}{dx} \\cos(x) = -\\sin(x) \\]                
""",
            integralLatex: """
\\[ \\int \\cos(x)\\, dx = \\sin x + C \\]                
""",
            function: CosineFunction(),
            bounds: (-2 * .pi, 2 * .pi),
        ),
        // 15
        FunctionDefinition(
            slug: "tangent",
            name: "正切函数", // Tangent Function
            category: .trigonometric,
            title: "y = tan(x)",
            latex: "y = \\tan(x)",
            derivativeLatex: """
\\[ \\frac{d}{dx} \\tan(x) = \\sec^2 x \\]                
""",
            integralLatex: """
\\[ &\\int \\tan(x)\\, dx \\\\= &-\\ln|\\cos(x)| + C \\]                
""",
            function: TangentFunction(),
            bounds: (-0.5 * .pi + 0.01, 0.5 * .pi - 0.01),
        ),
        // Stop Here.

//        FunctionDefinition(
//            slug: "arcsin",
//            name: "反正弦函数", // Arcsine Function
//            category: .trigonometric,
//            title: "y = arcsinx",
//            latex: "y = \\arcsin x",
//            derivativeLatex: "\\frac{dy}{dx} = \\frac{1}{\\sqrt{(1-x^2)}}",
//            integralLatex: "\\int y\\, dx = x · \\arcsin x + \\sqrt{1 - x^2} + C",
//            f: asin,
//            df: { x in 1/sqrt(1 - x * x) },
//            integral: { x in x * asin(x) + sqrt(1-x*x) }
//        ),
//
//        FunctionDefinition(
//            slug: "arccos",
//            name: "反余弦函数", // Arccosine Function
//            category: .trigonometric,
//            title: "y = arccosx",
//            latex: "y = \\arccos x",
//            derivativeLatex: "\\frac{dy}{dx} = -\\frac{1}{\\sqrt{(1-x^2)}}",
//            integralLatex: "\\int y\\, dx = x · \\arccos x - \\sqrt{1 - x^2} + C",
//            f: acos,
//            df: { x in -(1/sqrt(1-x*x)) },
//            integral: { x in
//                x * acos(x) - sqrt(1-x*x)
//            }
//        ),
//
//        FunctionDefinition(
//            slug: "arctan",
//            name: "反正切函数", // Arctangent Function
//            category: .trigonometric,
//            title: "y = arctanx",
//            latex: "y = \\arctan x",
//            derivativeLatex: "\\frac{dy}{dx} = \\frac{1}{1+x^2}",
//            integralLatex: "\\int y\\, dx = x · \\arctan x - \\frac{1}{2} \\lln (1 + x^2) + C",
//            f: atan,
//            df: { x in 1/(1+x*x) },
//            integral: { x in x * atan(x) - 0.5 * log(1+x*x) }
//        ),
//
//        FunctionDefinition(
//            slug: "sinh",
//            name: "双曲正弦函数", // Hyperbolic Sine
//            category: .hyperbolic,
//            title: "y = sinh(x)",
//            latex: "y = \\sinh x = \\frac{e^x - e^{-x}}{2}",
//            derivativeLatex: "\\frac{dy}{dx} = \\cosh x ",
//            integralLatex: "\\int y\\, dx = \\cosh x + C",
//            f: sinh,
//            df: cosh,
//            integral: cosh
//        ),
//
//        FunctionDefinition(
//            slug: "cosh",
//            name: "双曲余弦函数", // Hyperbolic Cosine
//            category: .hyperbolic,
//            title: "y = cosh(x)",
//            latex: "y = \\cosh x = \\frac{e^x + e^{-x}}{2}",
//            derivativeLatex: "\\frac{dy}{dx} = \\sinh x ",
//            integralLatex: "\\int y\\, dx = \\sinh x + C",
//            f: cosh,
//            df: sinh,
//            integral: sinh
//        ),
//
//        FunctionDefinition(
//            slug: "tanh",
//            name: "双曲正切函数", // Hyperbolic Tangent
//            category: .hyperbolic,
//            title: "y = tanh(x)",
//            latex: "y = \\tanh x = \\frac{e^x - e^{-x}}{e^x + e^{-x}}",
//            derivativeLatex: "\\frac{dy}{dx} = \\text{sech}^2 x ",
//            integralLatex: "\\int y\\, dx = \\ln \\cosh x + C ",
//            f: tanh,
//            df: { x in 1 / (cosh(x) * cosh(x)) },
//            integral: { x in 0.5 * x * x }
//        ),
//
//        FunctionDefinition(
//            slug: "reciprocal-linear",
//            name: "线性倒数函数", // Reciprocal Linear
//            category: .rational,
//            title: "y = 1/(x + a)",
//            latex: "y = \\frac{1}{x + a}",
//            derivativeLatex: "\\frac{dy}{dx} = -\\frac{1}{(x + a)^2}",
//            integralLatex: "\\int y\\, dx =  \\ln (x+a) + C ",
//            f: { x in Math.reciprocalLinear(x) },
//            df: { x in Math.dfReciprocalLinear(x) },
//            integral: { x in Math.intRecriprocalLinear(x)}
//        ),
//        
//        
//        FunctionDefinition(
//            slug: "inverse-distance",
//            name: "倒数距离函数", // Inverse Square Root Sum, Inverse Distance, 径向衰减函数
//            category: .rational,
//            title: "y = 1/√(a² + x²)",
//            // 定义域：所有实数 x ∈ (-∞, +∞)
//            // 值域: (0, 1/a]
//            // 连续且光滑：在整个实数轴上都连续、可导（无限可导）
//            // 该函数是偶函数 图像关于 y 轴对称。只需研究 x≥0 的部分即可
//            latex: "y = \\frac{1}{\\sqrt{a^2 + x^2}}",
//            derivativeLatex: "\\frac{dy}{dx} = -\\frac{x}{(a^2 + x^2)^{\\frac{3}{2}}}",
//            integralLatex: "\\int y\\, dx = \\ln (x + \\sqrt{a^2 + x^2}) + C ",
//            f: { x in 1/sqrt(4+x*x) },
//            df: { x in -x/pow(4+x*x, 1.5) },
//            integral: { x in log(x + sqrt(4 + x*x)) }
//        ),
//
//        FunctionDefinition(
//            slug: "reciprocal-affine",
//            name: "仿射倒数函数", // Reciprocal Affine
//            category: .rational,
//            title: "y = 1/(a ± bx)",
//            latex: "y = \\frac{1}{a ± bx}",
//            derivativeLatex: "\\frac{dy}{dx} = \\mp \\frac{b}{(a ± bx)^2}",
//            integralLatex: "\\int y\\, dx = ± \\frac{1}{b} \\ln (a ± bx) + C ",
//            f: { x in Math.reciprocalAffine(x) },
//            df: { x in Math.dfReciprocalAffine(x) },
//            integral: { x in Math.intReciprocalAffine(x) }
//        ),
//
//        FunctionDefinition(
//            slug: "inverse-cube-root-distance",
//            name: "倒数立方根距离函数", // Inverse Cube Root Distance, 三次方衰减函数
//            category: .rational,
//            title: "y = a²/(a² + x²)³/²",
//            latex: "y = \\frac{a^2}{(a^2 + x^2)^{\\frac{3}{2}}}",
//            derivativeLatex: "\\frac{dy}{dx} = -\\frac{3a^2x}{(a^2 + x^2)^{\\frac{5}{2}}}",
//            integralLatex: "\\int y\\, dx = \\frac{x}{\\sqrt{a^2 + x^2}} + C ",
//            f: { x in Math.inverseCubeRootDist(x) },
//            df: { x in Math.dfInverseCubeRootDist(x) },
//            integral: { x in Math.intInverseCubeRootDist(x) }
//        ),
//
//        FunctionDefinition(
//            slug: "sine-scaled",
//            // Scaled Sine Function，
//            // Frequency-Modulated Sine Function，调频正弦函数
//            name: "缩放的正弦函数",
//            category: .trigonometric,
//            title: "y = sin(ax)",
//            latex: "y = \\sin ax",
//            derivativeLatex: "\\frac{dy}{dx} =  a · \\cos ax",
//            integralLatex: "\\int y\\, dx = -\\frac{1}{a} \\cos ax + C ",
//            f: { x in Math.scaledSine(x) },
//            df: { x in Math.dfScaledSine(x) },
//            integral: { x in Math.intScaledSine(x) },
//            bounds: (-0.5 * .pi, 0.5 * .pi),
//        ),
//
//        FunctionDefinition(
//            slug: "cosine-scaled",
//            name: "缩放的余弦函数", // Scaled Cosine Function
//            category: .trigonometric,
//            title: "y = cos(ax)",
//            latex: "y = \\cos ax",
//            derivativeLatex: "\\frac{dy}{dx} = -a · \\sin ax",
//            integralLatex: "\\int y\\, dx =  \\frac{1}{a} \\sin ax + C ",
//            f: { x in Math.scaledCosine(x) },
//            df: { x in Math.dfScaledCosine(x) },
//            integral: { x in Math.intScaledCosine(x) },
//            bounds: (-0.5 * .pi, 0.5 * .pi),
//        ),
//
//        FunctionDefinition(
//            slug: "tangent-scaled",
//            name: "缩放的正切函数", // Scaled Tangent Function
//            category: .trigonometric,
//            title: "y = tan(ax)",
//            latex: "y = \\tan ax",
//            derivativeLatex: "\\frac{dy}{dx} =  a · \\sec^2ax",
//            integralLatex: "\\int y\\, dx = -\\frac{1}{a} \\ln \\cos ax + C ",
//            f: { x in Math.scaledTangent(x) },
//            df: { x in Math.dfScaledTangent(x) },
//            integral: { x in Math.intScaledTangent(x) },
//            bounds: (-0.25 * .pi, 0.25 * .pi),
//        ),
//
//        FunctionDefinition(
//            slug: "sine-squared",
//            name: "正弦平方函数", // Sine Squared
//            category: .trigonometric,
//            title: "y = sin² x",
//            latex: "y = \\sin^2 x",
//            derivativeLatex: "\\frac{dy}{dx} =  \\sin 2x",
//            integralLatex: "\\int y\\, dx = \\frac{x}{2} - \\frac{\\sin 2x}{4} + C ",
//            f: Math.sineSquared,
//            df: Math.dfSineSquared,
//            integral: Math.intSinceSquared,
//            bounds: (-.pi, .pi), // 显示两个完整周期
//        ),
//
//        FunctionDefinition(
//            slug: "cosine-squared",
//            name: "余弦平方函数", // Cosine Squared
//            category: .trigonometric,
//            title: "y = cos² x",
//            latex: "y = \\cos^2 x",
//            derivativeLatex: "\\frac{dy}{dx} = -\\sin 2x",
//            integralLatex: "\\int y\\, dx = \\frac{x}{2} + \\frac{\\sin 2x}{4} + C ",
//            f: Math.cosineSquared,
//            df: Math.dfCosineSquared,
//            integral: Math.intCosineSquared,
//            bounds: (-.pi, .pi),
//        ),
//        
//        // 周期取决于 n 的奇偶性，奇数 2pi，偶数 pi
//        FunctionDefinition(
//            slug: "sine-power",
//            name: "正弦的n次幂函数", // Sine to the Power n
//            category: .trigonometric,
//            title: "y =  sinⁿ x",
//            latex: "y =  \\sin^n x",
//            derivativeLatex: "\\frac{dy}{dx} = n · \\sin^{n-1} x · \\cos x",
//            integralLatex: "\\int y\\, dx = -\\frac{\\cos x}{n} \\sin^{n-1} x + \\frac{n-1}{n} \\int \\sin^{n-2} x\\, dx + C",
//            f: { x in Math.sinePower(x) },
//            df: { x in Math.dfSinePower(x) },
//            bounds: (-.pi, .pi),
//        ),
//
//        FunctionDefinition(
//            slug: "csc",
//            name: "余割函数", // Cosecant
//            category: .trigonometric,
//            title: "y = 1/(sin(x))",
//            latex: "y = \\frac{1}{\\sin x}",
//            derivativeLatex: "\\frac{dy}{dx} = -\\frac{\\cos x}{\\sin^2 x}",
//            integralLatex: "\\int y\\, dx = \\ln \\tan \\frac{x}{2} + C",
//            f: Math.csc,
//            df: Math.dfCsc,
//            integral: Math.intCsc,
//            bounds: (0, .pi)
//        ),
//
//        FunctionDefinition(
//            slug: "csc-squared",
//            name: "余割平方函数", // Cosecant Squared
//            category: .trigonometric,
//            title: "y = 1/(sin² x)",
//            latex: "y = \\frac{1}{\\sin^2 x}",
//            derivativeLatex: "\\frac{dy}{dx} = -\\frac{\\sin 2x}{\\sin^4 x}",
//            integralLatex: "\\int y\\, dx =  -\\text{cotan} x + C",
//            f: Math.cscSquared,
//            df: Math.dfCscSquared,
//            integral: Math.intCscSquared
//        ),
//
//        FunctionDefinition(
//            slug: "reciprocal-sine-cosine-product",
//            // Reciprocal of Sine-Cosine Product
//            // Double-Angle Cosecant Function, 双角余割函数
//            name: "正弦余弦乘积的倒数函数",
//            category: .trigonometric,
//            title: "y =  1/(sinx · cosx)",
//            latex: "y =  \\frac{1}{\\sin x · \\cos x}",
//            derivativeLatex: "\\frac{dy}{dx} = \\frac{\\sin^2 x - \\cos^2 x}{\\sin^2 x · \\cos^2 x}",
//            integralLatex: "\\int y\\, dx =  \\ln \\tan x + C ",
//            f: Math.secCscProduct,
//            df: Math.dfSecCscProduct,
//            integral: Math.intSecCscProduct,
//            bounds: (-0.5 * .pi + 0.01, 0.5 * .pi + 0.01)
//        ),
//
//        FunctionDefinition(
//            // 两个不同频率的余弦函数的线性组合
//            slug: "sine-product",
//            // Modulated Sine Wave    调制正弦波
//            // Product of Sines
//            name: "正弦乘积函数",
//            category: .trigonometric,
//            title: "y = sin(mx) · sin(nx)",
//            latex: "y = \\sin mx · \\sin nx",
//            derivativeLatex: "\\frac{dy}{dx} = n · \\sin mx · \\cos nx + m · \\sin nx · \\cos mx ",
//            integralLatex: "\\int y\\, dx = \\frac{1}{2} \\cos(m - n)x - \\frac{1}{2} \\cos(m + n)x + C",
//            f: { x in Math.sinesProduct(x) },
//            df: { x in Math.dfSinesProduct(x) },
//            integral: { x in Math.intSinesProduct(x) },
//            bounds: (-2 * .pi, 2 * .pi),
//        ),
//
//        FunctionDefinition(
//            slug: "sine-squared-scaled",
//            name: "缩放的正弦平方函数", // Sine Squared Scaled
//            category: .trigonometric,
//            title: "y = sin² ax",
//            latex: "y = \\sin^2 ax",
//            derivativeLatex: "\\frac{dy}{dx} =  2a·\\sin 2ax",
//            integralLatex: "\\int y\\, dx = \\frac{x}{2} - \\frac{\\sin 2ax}{4a} + C ",
//            f: { x in Math.sineSquaredScaled(x) },
//            df: { x in Math.dfSineSquaredScaled(x) },
//            integral: { x in Math.intSineSquaredScaled(x) }
//        ),
//
//        FunctionDefinition(
//            slug: "cosine-squared-scaled",
//            name: "缩放的余弦平方函数", // Cosine Squared Scaled
//            category: .trigonometric,
//            title: "y = cos² ax",
//            latex: "y = \\cos^2 ax",
//            derivativeLatex: "\\frac{dy}{dx} = -2a·\\sin 2ax",
//            integralLatex: "\\int y\\, dx = \\frac{x}{2} + \\frac{\\sin 2ax}{4a} + C ",
//            f: { x in Math.cosSquaredScaled(x) },
//            df: { x in Math.dfCosSquaredScaled(x) },
//            integral: { x in Math.intCosSquaredScaled(x) }
//        ),
    ]
}
