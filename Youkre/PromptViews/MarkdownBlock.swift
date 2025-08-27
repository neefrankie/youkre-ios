//
//  MarkdownBlock.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/27.
//

enum MarkdownBlock {
    case heading(level: Int, text: String)
    case paragraph(String)
    case listItem([String])
    case math(String)
    case image(String)
    case table([[String]])
}
