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
                blocks.append(parseBlockLatex(trimmed))
            } else if trimmed.hasPrefix("$$") && trimmed.hasSuffix("$$") {
                blocks.append(parseBlockLatex(trimmed))
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
    
    static func parseBlockLatex(_ line: String) -> MarkdownBlock {
        let text = String(
            line.dropFirst(2)
                .dropLast(2)
                .trimmingCharacters(in: .whitespaces)
        )
        
        guard !text.isEmpty else { return .math("") }
        
        // 尝试提取对齐环境
        if let (_, extractedContent) = extractAlignmentEnvironment(text) {
            return .math(extractedContent)
        }
    
        return .math(text)
    }
    
    static func parseAlignLatex(_ paragraph: String) -> MarkdownBlock? {
        if let (_, content) = extractAlignmentEnvironment(paragraph) {
            return .math(content)
        }
        return nil
    }
    
    /// 从字符串中提取 \begin{...}...\end{...} 环境的内容，支持多种环境
    /// - Returns: (环境名, 内容) 或 nil
    static func extractAlignmentEnvironment(_ input: String) -> (environment: String, content: String)? {
        let patterns = [
            "align\\*?",      // align 或 align*
            "aligned",        // aligned
            "gathered",       // gathered
            "split",          // split
            "equation\\*?"    // equation 或 equation*
        ]

        for pattern in patterns {
            // 构造 \begin{...} 的模式
            // \\begin Swift 会把它解释为：\begin（一个反斜杠）
            // 正则引擎看到的是 \begin
            // 但正则引擎中：
            // \b 是特殊含义：单词边界（word boundary）
            // 所以我们不能让正则引擎把 \b 当作“单词边界”，而要当作字面量 \ + b
            // → 所以我们必须写成
            // \\\\begin
            let beginPattern = "\\\\begin\\{\(pattern)\\}"
            let endPattern = "\\\\end\\{\(pattern)\\}"
            
            guard let beginRange = input.range(of: beginPattern, options: .regularExpression),
                  let endRange = input.range(of: endPattern, options: .regularExpression)
            else { continue }

            // 确保 \begin 在 \end 前
            guard beginRange.lowerBound < endRange.lowerBound else { continue }

            // 提取内容
            let contentStart = input.index(beginRange.upperBound, offsetBy: 0)
            let contentEnd = input.index(endRange.lowerBound, offsetBy: 0)
            let content = String(input[contentStart..<contentEnd])
                .trimmingCharacters(in: .whitespacesAndNewlines)

            return (pattern, content)
        }

        return nil
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
}
