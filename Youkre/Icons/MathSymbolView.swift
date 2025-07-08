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
    let fontSize: CGFloat
    let labelMode: MTMathUILabelMode
    let textColor: Color
    
    init(
        latex: String,
        fontSize: CGFloat = 22,
        mode: MTMathUILabelMode = .text,
        textColor: Color = .white
    ) {
        self.latex = latex
        self.fontSize = fontSize
        self.labelMode = mode
        self.textColor = textColor
    }
    
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

struct IconBoxView<Content: View>: View {
    var size: CGFloat = 44
    var background: Color = .gray.opacity(0.3)
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        ZStack {
            RoundedRectangle(
                cornerRadius: size * 0.25
            )
                .fill(background)
            
            content()
                .frame(
                    width: size * 0.55,
                    height: size * 0.55
                )
                .foregroundColor(.white)
        }
        .frame(width: size, height: size)
    }
}

struct TocIconStyle: ViewModifier {
    let background: Color
    
    init(_ background: Color = .indigo) {
        self.background = background
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: 44, height: 44)
            .background(background)
            .cornerRadius(12)
    }
}

