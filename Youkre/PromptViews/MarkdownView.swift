//
//  MarkdownView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/17.
//

import SwiftUI

struct MarkdownView: View {
    let markdown: String
    var spacing: CGFloat = 16
    var latexFontSize: CGFloat = 20
    
    @State private var isLoading = true
    @State private var blocks: [MarkdownBlock] = []
    
    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView()
            } else {
                VStack(alignment: .leading, spacing: spacing) {
                    ForEach(blocks.indices, id: \.self) { idx in
                        MarkdownBlockView(
                            block: blocks[idx],
                            latexFontSize: latexFontSize
                        )
                    }
                }
                .padding()
            }
        }
        .onAppear {
            parse()
        }
    }
    
    func parse() {
        isLoading = true
        self.blocks = MarkdownParser.parse(markdown)
        isLoading = false
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
    
    | 科学 | 34 | 
    | --- | --- |
    | 英语 | 90 | 
    | 历史 | 87 | 
    | 数学 | 34 |  
    | 地理 | 55 | 
    """#
    VStack {
        Text("Large Title")
            .font(.largeTitle)
            .bold()
        MarkdownView(markdown: sampleMarkdown)
    }
    
}
