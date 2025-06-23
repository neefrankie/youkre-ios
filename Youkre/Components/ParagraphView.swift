//
//  ParagraphView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/22.
//

import SwiftUI

struct ParagraphView: View {
    let paragraph: Paragraph
    
    var body: some View {
        Group {
            if paragraph.type == .text {
                MarkdownBlockView(
                    block: TextUtils.parseMarkdown(paragraph.content)[0]
                )
            } else {
                MathView(equation: paragraph.content)
                    .fixedSize()
            }
        }
    }
}

#Preview {
    VStack {
        ParagraphView(
            paragraph: Paragraph(
                content: "**乘积法则** 如果 *y = uv*，则",
                type: .text
            )
        )
        .background(.red)
        
        ParagraphView(
            paragraph: Paragraph(
                content: "\\frac{dy}{dx} = u\\, \\frac{dv}{dx} + v\\, \\frac{du}{dx}",
                type: .math
            )
        )
        .background(.red)
    }
    
}
