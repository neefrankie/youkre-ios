//
//  MathView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/18.
//

import SwiftUI
import SwiftMath

struct MathView: UIViewRepresentable {
    var equation: String
    var font: MathFont = .latinModernFont
    var fontSize: CGFloat = 30
    var textColor: Color = .primary
    var textAlignment: MTTextAlignment = .center
    var labelMode: MTMathUILabelMode = .text
    var insets: MTEdgeInsets = MTEdgeInsets()
    
    func makeUIView(context: Context) -> MTMathUILabel {
        let view = MTMathUILabel()
        view.labelMode = labelMode
        view.textAlignment = textAlignment
        return view
    }
    func updateUIView(_ view: MTMathUILabel, context: Context) {
        view.latex = equation
        view.font = MTFontManager().font(withName: font.rawValue, size: fontSize)
        view.textColor = MTColor(textColor)
        
        view.contentInsets = insets
        
        view.sizeToFit()
    }
}

#Preview {
    MathView(
        equation: "y = x \\\\ y = x^2"
    )
    .fixedSize()
    
    MathView(
        equation: "\\frac{dy}{dx} = \\cos(x)"
    )
    .fixedSize()
    
    MathView(
        equation: "\\int y\\,dx = -\\cos(x) + C"
    )
    .fixedSize()
}
