//
//  TextUtils.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/9/15.
//

import Foundation

struct ParsedPath {
    let name: String
    let suffix: String
    let directory: String?
    
    var isSvg: Bool {
        suffix.lowercased() == "svg"
    }
    
    var isPdf: Bool {
        suffix.lowercased() == "pdf"
    }
}

struct TextUtils {
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
    
    // Example: /images/exercise/triangle-inequality-theorem--ex-10.png
    // witll be
    // name: "triangle-inequality-theorem--ex-10",
    // type: "png",
    // directory: Optional("images/exercise")
    static func parseImagePath(_ path: String) -> ParsedPath {
        let url = URL(fileURLWithPath: path)
//        let fileNameWithExtension = url.lastPathComponent
        
        let name = url.deletingPathExtension().lastPathComponent
        let type = url.pathExtension
        
        // 获取目录部分并清理前后可能存在的斜杠
        var directory = url.deletingLastPathComponent().path()
        // 移除开头和结尾的斜杠
        if directory.hasPrefix("/") {
            directory.remove(at: directory.startIndex)
        }
        if directory.hasSuffix("/") {
            directory.remove(at: directory.index(before: directory.endIndex))
        }
        
        return ParsedPath(
            name: name,
            suffix: type,
            directory: directory.isEmpty ? nil : directory,
        )
    }
    
    static func hasFrac(latex: String) -> Bool {
        return latex.contains(#"\frac"#)
    }
}
