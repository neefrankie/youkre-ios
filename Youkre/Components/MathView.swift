//
//  MathView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/18.
//

import SwiftUI
import SwiftMath

struct MathView: UIViewRepresentable {
    let latex: String
    var fontSize: CGFloat = 30
    var labelMode: MTMathUILabelMode = .text
    var textAlignment: MTTextAlignment = .center
    var font: MathFont = .latinModernFont
    var textColor: Color = .primary
    
    func makeUIView(context: Context) -> MTMathUILabel {
        let view = MTMathUILabel()
        view.latex = latex
        view.labelMode = labelMode
        view.textAlignment = textAlignment
        view.font = MTFontManager().font(withName: font.rawValue, size: fontSize)
        view.textColor = MTColor(textColor)
        return view
    }
    
    func updateUIView(_ view: MTMathUILabel, context: Context) {
        view.sizeToFit()
    }
}

#Preview {
    VStack {
        MathView(
            latex: #"""
    y = x \\
    y = x^2
    """#
        )
        .fixedSize()
        
        MathView(
            latex: #"\frac{dy}{dx} = \cos(x)"#,
            font: .firaFont
        )
        .fixedSize()
        
        MathView(
            latex: #"\frac{dy}{dx} = \cos(x)"#,
            font: .asanaFont
        )
        .fixedSize()
        MathView(
            latex: #"\frac{dy}{dx} = \cos(x)"#,
            font: .notoSansFont
        )
        .fixedSize()
        MathView(
            latex: #"\frac{dy}{dx} = \cos(x)"#,
            font: .eulerFont
        )
        .fixedSize()
        MathView(
            latex: #"\frac{dy}{dx} = \cos(x)"#,
            font: .kpMathSansFont
        )
        .fixedSize()
        MathView(
            latex: #"\frac{dy}{dx} = \cos(x)"#,
            font: .libertinusFont
        )
        .fixedSize()
        
        MathView(
            latex: #"\int y\,dx = -\cos(x) + C"#,
        )
        .fixedSize()
        
        MathView(
            latex: #"你好, \int"#,
        )
        .fixedSize()
    }
}
