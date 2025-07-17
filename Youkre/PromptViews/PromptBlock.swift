//
//  PromptBlock.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/14.
//

enum TableLayout: Codable, Hashable {
    case columns(Int)
    case rows(Int)
}

enum PromptBlock: Codable, Hashable {
    case text(String)
    case latex(String)
    case image(name: String)
    case table(data: [String], layout: TableLayout)
    case bullet(String)
    case newline
}
