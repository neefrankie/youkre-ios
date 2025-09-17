//
//  MarkdownScrollView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/9/16.
//

import SwiftUI

struct MarkdownScrollView: View {
    let markdown: String
    var spacing: CGFloat = 16
    var latexFontSize: CGFloat = 24
    var titleAlignment: Alignment = .center
    
    @State private var isLoading = true
    @State private var blocks: [MarkdownBlock] = []
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else {
                ScrollView(showsIndicators: false) {
                    MarkdownListView(
                        blocks: blocks,
                        spacing: spacing,
                        latexFontSize: latexFontSize,
                        titleAlignment: titleAlignment,
                    )
                    .padding()
                }
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
    
    ![](/images/exercise/triangle-inequality-theorem--ex-10.png)
    
    | 科学 | 34 | 
    | --- | --- |
    | 英语 | 90 | 
    | 历史 | 87 | 
    | 数学 | 34 |  
    | 地理 | 55 | 
    """#
    MarkdownScrollView(markdown: sampleMarkdown)
    
}
