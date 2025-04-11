//
//  Book.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/3/13.
//

struct TocEntry: Identifiable, Codable, Hashable {
    let id: String
    let slug: String
    let text: String
    let title: String
    let subtitle: String
}

struct TableOfContents: Codable {
    let title: String
    let items: [TocEntry]
}

struct Book: Codable, Identifiable, Hashable {
    let id: String
    let slug: String
    let title: String
    let cover: String
    let body: [String]
    
    var text: String {
        body.joined(separator: "\n\n")
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(slug)
    }
}

struct ChapterParams: Hashable {
    let book: Book
    let tocEntry: TocEntry
}

class DataStore {
    static let bookList: [Book] = [
        Book(
            id: "calculus-made-easy",
            slug: "calculus-made-easy",
            title: "简易微积分",
            cover: "calculus-made-easy",
            body: [
                "微积分是自然科学的基石，大多数工程问题离不开微积分进行优化。其他数学科目线性代数、概率论、统计学等也依赖微积分提供前置知识。",
                "很多微积分技巧并不难，但许多教材往往强调复杂的方法，而忽略了如何做到浅显易懂。",
                "“简易微积分”系列尝试用简单、直白的语言，向普通人解释微积分，帮助初学者学会微积分的语言，熟悉它的简洁优雅，轻松掌握微积分的真正精髓和解决问题的强大方法。你会发现大多数微积分运算很简单。别人能学会的东西，你也能学会。"
            ]
        )
    ]
}
