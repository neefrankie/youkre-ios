//
//  TextUtils.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/22.
//

import Foundation

struct MarkdownBlock: Identifiable {
    enum BlockType {
        case heading(level: Int)
        case paragraph
        case listItem
        case math
    }
    
    let id = UUID()
    let type: BlockType
    let text: String
}

struct Paragraph {
    enum ParaType {
        case text
        case math
    }
    
    let id = UUID()
    let content: String
    let type: ParaType
}

struct TextUtils {
    static func parseMarkdown(_ input: String) -> [MarkdownBlock] {
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
            } else if trimmed.hasPrefix("### ") {
                blocks.append(
                    .init(
                        type: .heading(level: 3),
                        text: String(trimmed.dropFirst(4))
                    )
                )
            } else if trimmed.hasPrefix("\\[") && trimmed.hasSuffix("\\]") {
                blocks.append(
                    .init(
                        type: .math,
                        text: String(trimmed.dropFirst(2).dropLast(2).trimmingCharacters(in: .whitespaces))
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
    
    static func attributed(from text: String) -> AttributedString {
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
}
