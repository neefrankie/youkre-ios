//
//  TextUtils.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/22.
//

import Foundation

struct MarkdownParser {
    static func parse(_ input: String) -> [MarkdownBlock] {
        let lines = input.components(separatedBy: "\n\n")
        var blocks: [MarkdownBlock] = []
        
        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            
            if trimmed.hasPrefix("#") {
                blocks.append(parseHeading(trimmed))
            } else if trimmed.hasPrefix("\\[") && trimmed.hasSuffix("\\]") {
                blocks.append(parseSquareLatex(trimmed))
            } else if trimmed.hasPrefix("$$") && trimmed.hasSuffix("$$") {
                blocks.append(parseDollarLatex(trimmed))
            } else if trimmed.hasPrefix("\\begin{align") {
                if let latex = parseAlignLatex(trimmed) {
                    blocks.append(latex)
                }
            } else if trimmed.hasPrefix("- ") || trimmed.hasPrefix("* ") {
                blocks.append(parseList(trimmed))
            } else if trimmed.hasPrefix("![") {
                if let img = parseImage(from: trimmed) {
                    blocks.append(img)
                }
            } else if trimmed.hasPrefix("|") && trimmed.hasSuffix("|") {
                blocks.append(parseTable(trimmed))
            } else if !trimmed.isEmpty {
                blocks.append(.paragraph(trimmed))
            }
        }
        
        return blocks
    }
    
    static func countHeadingLevel(_ line: String) -> Int {
        var count = 0
        for char in line {
            if char == "#" {
                count += 1
            } else {
                break
            }
        }
        return min(count, 6)
    }
    
    static func parseHeading(_ line: String) -> MarkdownBlock {
        let level = countHeadingLevel(line)
        let text = String(line.dropFirst(level)).trimmingCharacters(in: .whitespaces)
        
        return .heading(level: level, text: text)
    }
    
    static func parseList(_ line: String) -> MarkdownBlock {
        let lines = line.components(separatedBy: "\n")
            .map{
                String(
                    $0.trimmingCharacters(in: .whitespaces)
                        .dropFirst(2)
                )
            }
        
        return .listItem(lines)
    }
    
    static func parseTable(_ paragraph: String) -> MarkdownBlock {
        var tableRows: [[String]] = []
        
        var charSet = CharacterSet()
        charSet.insert(charactersIn: "|")
        
        let lines = paragraph.components(separatedBy: "\n")
            .map{
                String($0.trimmingCharacters(in: .whitespaces).trimmingCharacters(in: charSet))
            }
        
        for line in lines {
            if let row = parseTableRow(line) {
                if !isSeparatorRow(row) {
                    tableRows.append(row)
                }
            }
        }
        
        return .table(tableRows)
    }
    
    // 检查是否为分隔行（|---|---|...）
    static func isSeparatorRow(_ row: [String]) -> Bool {
        return row.allSatisfy { cell in
            let trimmed = cell.trimmingCharacters(in: .whitespaces)
            return trimmed.allSatisfy { $0 == "-" || $0 == ":" }
        }
    }
    
    static func parseTableRow(_ line: String) -> [String]? {
        let charSet = CharacterSet(charactersIn: "|").union(.whitespacesAndNewlines)
        
        let content = line.trimmingCharacters(in: charSet)
        
        // 按 | 分割
        let cells = content
            .split(separator: "|", omittingEmptySubsequences: false)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        
        return cells.isEmpty ? nil : Array(cells)
    }
    
    static func parseSquareLatex(_ line: String) -> MarkdownBlock {
        let text = String(
            line.dropFirst(2)
                .dropLast(2)
                .trimmingCharacters(in: .whitespaces)
        )
        
        return .math(text)
    }
    
    static func parseDollarLatex(_ line: String) -> MarkdownBlock {
        let text = String(
            line.dropFirst(2)
                .dropLast(2)
                .trimmingCharacters(in: .whitespaces)
        )
        
        return .math(text)
    }
    
    static func parseAlignLatex(_ paragraph: String) -> MarkdownBlock? {
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
            .trimmingCharacters(in: .whitespacesAndNewlines)

        return .math(content)
    }
    
    static func parseImage(from line: String) -> MarkdownBlock? {
        let pattern = #"!\[([^\]]*)\]\(([^)\s]+)(?:\s+"([^"]*)")?\)"#
        
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: line, range: NSRange(line.startIndex..., in: line)) else {
            return nil
        }
        
        let range = match.range(at: 2)
        if range.location != NSNotFound {
            let result = (line as NSString).substring(with: range)
            return .image(result)
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
