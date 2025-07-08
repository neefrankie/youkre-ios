//
//  MathSymbols.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/8.
//

import SwiftUI
import SwiftMath

struct LatexIconView: UIViewRepresentable {
    let latex: String

    var fontSize: CGFloat = 18
    var textColor: Color = .white
    var labelMode: MTMathUILabelMode = .text
    
    func makeUIView(context: Context) -> MTMathUILabel {
        let label = MTMathUILabel()
        label.latex = latex
        label.fontSize = fontSize
        label.textAlignment = .center
        label.contentInsets = .zero
        label.backgroundColor = .clear
        label.textColor = MTColor(textColor)
        label.labelMode = labelMode
        
        return label
    }
    func updateUIView(_ uiView: MTMathUILabel, context: Context) {
        uiView.latex = latex
    }
}

struct MathIconStyle: ViewModifier {
    let background: Color
    
    init(_ background: Color = .indigo) {
        self.background = background
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: 44, height: 44)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(background)
            )
    }
}

struct MathSymbolView: View {
    let latex: String
    let fontSize: CGFloat
    let mathMode: MTMathUILabelMode
    
    init(
        latex: String,
        fontSize: CGFloat = 22,
        mode: MTMathUILabelMode = .text
    ) {
        self.latex = latex
        self.fontSize = fontSize
        self.mathMode = mode
    }
    
    var body: some View {
        LatexIconView(
            latex: self.latex,
            fontSize: self.fontSize,
            labelMode: mathMode
        )
        .frame(width: 24, height: 24)
    }
}

struct CompositionSymbol: View {
    var body: some View {
        MathSymbolView(
            latex: "f\\circ g",
            fontSize: 18
        )
    }
}

struct DefiniteIntegralSymbol: View {
    var body: some View {
        MathSymbolView(
            latex: "\\int_a^b",
        )
    }
}

struct DerivativeSymbol: View {
    var body: some View {
        MathSymbolView(
            latex: "\\frac{d}{dx}",
        )
    }
}

struct ExponentialSymbol: View {
    var body: some View {
        MathSymbolView(
            latex: "e^x"
        )
    }
}

struct FractionSymbol: View {
    var body: some View {
        MathSymbolView(
            latex: "\\frac{a}{b}"
        )
    }
}

struct FunctionSymbol: View {
    var body: some View {
        MathSymbolView(
            latex: "f(x)",
            fontSize: 18
        )
    }
}

struct IntegralSymbol: View {
    var body: some View {
        MathSymbolView(latex: "\\int")
    }
}

struct LimitSymbol: View {
    var body: some View {
        MathSymbolView(
            latex: "\\lim_{x \\to 0}",
            fontSize: 18,
            mode: .display
        )
    }
}

struct LogarithmSymbol: View {
    var body: some View {
        MathSymbolView(
            latex: "\\ln x"
        )
    }
}

struct ProductSymbol: View {
    var body: some View {
        MathSymbolView(
            latex: "\\prod"
        )
    }
}

struct SequenceSymbol: View {
    var body: some View {
        MathSymbolView(
            latex: "a_n"
        )
    }
}

struct SetNotationSymbol: View {
    var body: some View {
        MathSymbolView(
            latex: "\\in, \\mathbb{R}",
            fontSize: 18
        )
    }
}

struct SumSymbol: View {
    var body: some View {
        MathSymbolView(
            latex: "\\sum"
        )
    }
}

struct VectorSymbol: View {
    var body: some View {
        MathSymbolView(
            latex: "\\vec{v}"
        )
    }
}



#Preview {
    ScrollView {
        VStack {
            CompositionSymbol()
                .modifier(MathIconStyle())
            DefiniteIntegralSymbol()
                .modifier(MathIconStyle(.red))
            DerivativeSymbol()
                .modifier(MathIconStyle(.orange))
            ExponentialSymbol()
                .modifier(MathIconStyle(.brown))
            FractionSymbol()
                .modifier(MathIconStyle(.cyan))
            FunctionSymbol()
                .modifier(MathIconStyle(.mint))
            IntegralSymbol()
                .modifier(MathIconStyle(.teal))
            LimitSymbol()
                .modifier(MathIconStyle(.pink))
            LogarithmSymbol()
                .modifier(MathIconStyle(.pink))
            ProductSymbol()
                .modifier(MathIconStyle(.green))
            SequenceSymbol()
                .modifier(MathIconStyle(.yellow))
            SetNotationSymbol()
                .modifier(MathIconStyle(.blue))
            SumSymbol()
                .modifier(MathIconStyle(.indigo))
            VectorSymbol()
                .modifier(MathIconStyle())
        }
        .frame(maxWidth: .infinity)
    }
    
}
