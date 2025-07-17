//
//  MarkdownView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/17.
//

import SwiftUI

struct MarkdownBlockView: View {
    let block: MarkdownBlock
    var latexFontSize: CGFloat = 20
    
    var body: some View {
        switch block.type {
        case .heading(let level):
            Text(block.text)
                .modifier(TitleStyle(level: level))
        case .paragraph:
            Text(TextUtils.attributed(from: block.text))
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
        case .listItem:
            HStack(alignment: .top) {
                Text("•")
                Text(TextUtils.attributed(from: block.text))
            }
        case .math:
            MathView(
                latex: block.text,
                fontSize: latexFontSize,
            )
            .fixedSize(horizontal: false, vertical: true)
        case .image:
            Image(block.text)
                .resizable()
                .scaledToFit()
        }
    }
}

struct MarkdownListView: View {
    let markdown: String
    var spacing: CGFloat = 16
    var latexFontSize: CGFloat = 20
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(TextUtils.parseMarkdown(markdown), id: \.id) { block in
                MarkdownBlockView(
                    block: block,
                    latexFontSize: latexFontSize
                )
            }
        }
    }
}

struct MarkdownView: View {
    let markdown: String
    
    var body: some View {
        ScrollView {
            MarkdownListView(markdown: markdown)
        }
    }
}


#Preview {
    let sampleMarkdown = #"""
    # Welcome to SwiftUI
    
    ## Welcome to SwiftUI
    
    ### Welcome to SwiftUI

    This is a custom **Markdown** renderer.

    - Easy to use
    - Supports *basic* styling
    - [Visit Apple](https://apple.com)

    ## Thanks for Reading
    
    \[ \frac{dy}{dx} = u\, \frac{dv}{dx} + v\, \frac{du}{dx} \]
    
    Order of Operations are:

    * Parentheses (Brackets) first
    * Exponents (Orders, Powers, Square Roots, etc.) next
    * Multiplication and Division (left-to-right) next
    * Addition and Subtraction (left-to-right) last

    So we do the division and multiplication before the addition:

    \begin{align*}
    6 \div 3 = 2 \\
    4 \times 2 = 8
    \end{align*}

    So 

    \begin{align*}
    &6 \div 3 + 4 \times 2 \\
    = &2 + 8 \\
    = &10
    \end{align*}
    
    $$
    \frac{d}{dx}x^{13} = 13x^{12}
    $$
    
    ![](calculus-made-easy)
    """#
    VStack {
        Text("Large Title")
            .font(.largeTitle)
            .bold()
        MarkdownView(markdown: sampleMarkdown)
            .padding()
    }
    
}
