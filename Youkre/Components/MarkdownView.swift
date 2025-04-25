//
//  MarkdownView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/17.
//

import SwiftUI

struct MarkdownBlock: Identifiable {
    enum BlockType {
        case heading(level: Int)
        case paragraph
        case listItem
    }
    
    let id = UUID()
    let type: BlockType
    let text: String
}

struct MarkdownView: View {
    let markdown: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(parseMarkdown(markdown), id: \.id) { block in
                    
                    switch block.type {
                    case .heading(let level):
                        Text(block.text)
                            .font(level == 1 ? .largeTitle : .title2)
                            .bold()
                    case .paragraph:
                        Text(attributed(from: block.text))
                            .foregroundStyle(.primary)
                    case .listItem:
                        HStack(alignment: .top) {
                            Text("•")
                            Text(attributed(from: block.text))
                        }
                    }
                    
                }
            }
            .padding()
        }
    }
    
    func attributed(from text: String) -> AttributedString {
        do {
            var options = AttributedString.MarkdownParsingOptions()
            options.interpretedSyntax = .inlineOnlyPreservingWhitespace
            options.allowsExtendedAttributes = true
            return try AttributedString(
                markdown: text,
                options: options
            )
        } catch {
            return AttributedString(text)
        }
    }
    
    func parseMarkdown(_ input: String) -> [MarkdownBlock] {
        let lines = input.components(separatedBy: .newlines)
        var blocks: [MarkdownBlock] = []
        
        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            
            if trimmed.hasPrefix("# ") {
                blocks.append(
                    .init(
                        type: .heading(level: 1),
                        text: String(trimmed.dropFirst(2))
                    )
                )
            } else if trimmed.hasPrefix("## ") {
                blocks.append(
                    .init(
                        type: .heading(level: 2),
                        text: String(trimmed.dropFirst(3))
                    )
                )
            } else if trimmed.hasPrefix("- ") {
                blocks.append(
                    .init(
                        type: .listItem,
                        text: String(trimmed.dropFirst(2))
                    )
                )
            } else if !trimmed.isEmpty {
                blocks.append(
                    .init(
                        type: .paragraph,
                        text: trimmed)
                )
            }
        }
        
        return blocks
    }
}


#Preview {
    let sampleMarkdown = """
    # Welcome to SwiftUI

    This is a custom **Markdown** renderer.

    - Easy to use
    - Supports *basic* styling
    - [Visit Apple](https://apple.com)

    ## Thanks for Reading
    """
    
    MarkdownView(markdown: sampleMarkdown)
}
