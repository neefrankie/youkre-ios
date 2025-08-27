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
        case image
    }
    
    let id = UUID()
    let type: BlockType
    let text: String
}



struct TextUtils {
    static func parseMarkdown(_ input: String) -> [MarkdownBlock] {
        let lines = input.components(separatedBy: "\n\n")
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
            } else if trimmed.hasPrefix("$$") && trimmed.hasSuffix("$$") {
                blocks.append(
                    .init(
                        type: .math,
                        text: String(trimmed.dropFirst(2).dropLast(2).trimmingCharacters(in: .whitespaces))
                     )
                )
            } else if trimmed.hasPrefix("\\begin{align") {
                let latex = extractAlignContent(from: trimmed)
                if let latex {
                    blocks.append(
                        .init(
                            type: .math,
                            text: latex
                        )
                    )
                }
            } else if trimmed.hasPrefix("- ") || trimmed.hasPrefix("* ") {
                let lines = trimmed.components(separatedBy: "\n")
                    .map{ String($0.trimmingCharacters(in: .whitespaces).dropFirst(2)) }
                
                let listItems = lines.map{ MarkdownBlock(type: .listItem, text: $0) }
                
                blocks += listItems
            } else if trimmed.hasPrefix("![") {
                if let src = extractImage(from: trimmed) {
                    blocks.append(
                        .init(
                            type: .image,
                            text: src
                        )
                    )
                }
            } else if !trimmed.isEmpty {
                blocks.append(
                    .init(
                        type: .paragraph,
                        text: trimmed
                    )
                )
            }
        }
        
        return blocks
    }
    
    static func extractAlignContent(from paragraph: String) -> String? {
        let beginMarker = "\\begin{align*}"
        let endMarker = "\\end{align*}"

        guard let beginRange = paragraph.range(of: beginMarker),
              let endRange = paragraph.range(of: endMarker, options: [], range: nil)
        else {
            // 没有找到完整的 \begin{align*} 或 \end{align*}
            return nil
        }

        // 确保 \begin 在 \end 前面
        guard beginRange.lowerBound < endRange.lowerBound else {
            return nil
        }

        // 提取中间内容
        let contentStart = beginRange.upperBound
        let contentEnd = endRange.lowerBound
        let content = String(paragraph[contentStart..<contentEnd])

        return content.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static func extractImage(from line: String) -> String? {
        let pattern = #"!\[([^\]]*)\]\(([^)\s]+)(?:\s+"([^"]*)")?\)"#
        
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: line, range: NSRange(line.startIndex..., in: line)) else {
            return nil
        }
        
        let range = match.range(at: 2)
        if range.location != NSNotFound {
            let result = (line as NSString).substring(with: range)
            return result
        }
        
        return nil
    }
    
    // Split filename into (stem, ext).
    // Exmple:
    // hello.png -> (hello, .png)
    // hello -> (hello, '')
    static func splitFilenameAndExtension(_ filename: String) -> (name: String, ext: String)? {
        guard let lastDotIndex = filename.lastIndex(of: ".") else {
            return nil // 没有后缀
        }

        let name = String(filename[..<lastDotIndex])
        let ext = String(filename[lastDotIndex...])
        
        return (name, ext)
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
