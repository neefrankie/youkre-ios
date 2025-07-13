//
//  ParagraphView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/22.
//

import SwiftUI

struct Sentence {
    enum ParaType {
        case text
        case math
    }
    
    let id = UUID()
    let content: String
    let type: ParaType
}

struct SentenceView: View {
    let sentence: Sentence
    
    var body: some View {
        Group {
            if sentence.type == .text {
                Text(sentence.content)
            } else {
                MathView(
                    latex: sentence.content,
                    fontSize: 18
                )
                    .fixedSize()
            }
        }
    }
}

#Preview {
    VStack {
        SentenceView(
            sentence: Sentence(
                content: "**乘积法则** 如果 *y = uv*，则",
                type: .text
            )
        )
        .background(.red)
        
        SentenceView(
            sentence: Sentence(
                content: "\\frac{dy}{dx} = u\\, \\frac{dv}{dx} + v\\, \\frac{du}{dx}",
                type: .math
            )
        )
        .background(.red)
    }
    
}
