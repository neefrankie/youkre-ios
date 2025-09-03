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
    
    var body: some View {
        switch block {
        case .heading(let level, let heading):
            Text(heading)
                .modifier(TitleStyle(level: level))
        case .paragraph(let text):
            Text(MarkdownParser.attributed(from: text))
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
        case .listItem(let items):
            UnorderedListView(items: items)
        case .math(let latex):
            MathView(
                latex: latex,
                fontSize: latexFontSize,
            )
            .fixedSize(horizontal: false, vertical: true)
        case .image(let name):
            Image(name)
                .resizable()
                .scaledToFit()
        case .table(let rows):
            ScrollView(.horizontal) {
                TableDataView(
                    rows: rows
                )
            }
        }
    }
}
