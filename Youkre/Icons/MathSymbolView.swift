//
//  MathSymbols.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/8.
//

import SwiftUI
import SwiftMath

struct LatexIconView: View {
    let latex: String
    var fontSize: CGFloat = 22
    var mode: MTMathUILabelMode = .text
    
    var body: some View {
        MathView(
            latex: latex,
            fontSize: fontSize,
            labelMode: mode,
            textColor: .white
        )
        .fixedSize()
        .background(.clear)
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

