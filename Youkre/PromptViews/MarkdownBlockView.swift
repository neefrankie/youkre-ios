//
//  MarkdownBlockView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/27.
//


import SwiftUI



struct MarkdownBlockView: View {
    let block: MarkdownBlock
    var latexFontSize: CGFloat = 24
    var texScaleFactor: CGFloat = 1.2
    var titleAlignment: TextAlignment = .center
    
    var body: some View {
        switch block {
        case .heading(let level, let heading):
            Text(heading)
                .font(titleFont(level: level))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(titleAlignment)
                .padding(16)
        case .paragraph(let text):
            Text(TextUtils.attributed(from: text))
                .multilineTextAlignment(.leading)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
        case .listItem(let items):
            UnorderedListView(items: items)
        case .math(let latex):
            let hasFrac = TextUtils.hasFrac(latex: latex)
            MathView(
                latex: latex,
                fontSize: hasFrac ? latexFontSize * texScaleFactor : latexFontSize,
            )
            .fixedSize(horizontal: false, vertical: true)
            
        case .image(let path):
            AspectRatioView {
                BundleImage(path)
            }
        case .table(let rows):
            ScrollView(.horizontal) {
                TableDataView(
                    rows: rows
                )
            }
        }
    }
    
    func titleFont(level: Int) -> Font? {
        switch level {
        case 1:
            return Font.title
        case 2:
            return Font.title2
        case 3:
            return Font.title3
        default:
            return nil
        }
    }
}

struct MarkdownListView: View {
    var blocks: [MarkdownBlock]
    
    var spacing: CGFloat = 16
    var latexFontSize: CGFloat = 24
    var titleAlignment: Alignment = .center
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(blocks.indices, id: \.self) { idx in
                MarkdownBlockView(
                    block: blocks[idx],
                    latexFontSize: latexFontSize
                )
            }
        }
    }
}

#Preview {
    VStack {
        MarkdownBlockView(
            block: .math(#"""
\frac{dD}{dT} &= \frac{1}{\pi} \cdot l_t \cdot \frac{d}{dT} [1 + 0.000012(T-t)] \\
&= \frac{1}{\pi} \cdot l_t \cdot 0.000012 \\
&= \frac{l_t}{\pi} \times 0.000012
"""#)
        )
        MarkdownBlockView(
            block: .math(#"""
L &= \pi D \\
D &= \frac{L}{\pi}
"""#)
        )
        MarkdownBlockView(
            block: .math(#"""
&= -\frac{1}{2DL} \sqrt{\frac{gT}{\pi \sigma^3}}
"""#)
        )
        MarkdownBlockView(block: .heading(level: 3, text: "Hello Title"))
        MarkdownBlockView(
            block: .math(#"""
&\frac{du}{dz} \\
= &\frac{1}{c} \cdot (a n z^{n-1}) \\
= &\frac{a n z^{n-1}}{c}
"""#)
        )
    }
}
