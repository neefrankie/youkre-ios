//
//  PromptBlock.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/14.
//

enum PromptBlock: Codable, Hashable {
    case text(String)
    case latex(String)
    case iamge(name: String)
    case table(rows: [[String]])
    case bullet(String)
    case newline
}
