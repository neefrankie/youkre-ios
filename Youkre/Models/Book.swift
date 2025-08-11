//
//  Course.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/5.
//

struct Book: Identifiable, Hashable {
    let id: String
    let slug: String
    let title: String
    let cover: String
    let summary: String
    let icon: IconSymbol
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(slug)
    }
    
    static func ==(lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
    
    static let bookList: [Book] = [
        Book(
            id: "5bd2c24bd901b5a9",
            slug: "calculus-made-easy",
            title: "简易微积分",
            cover: "calculus-made-easy",
            summary: "简单易懂的微积分",
            icon: .latex("integral")
        ),
        Book(
            id: "6b927048e42cc585",
            slug: "elementary-algebra",
            title: "初级代数",
            cover: "elementary-algebra",
            summary: "用字母、数字和符号来“玩”的游戏",
            icon: .latex("x")
        ),
        Book(
            id: "ad7dd3035d82eda3",
            slug: "elementary-statistics",
            title: "概率统计入门",
            cover: "elementary-statistics",
            summary: "预测事情发生的可能性，找出规律",
            icon: .text("P")
        ),
        Book(
            id: "9b08c5f3f19338c4",
            slug: "elementary-trigonometry",
            title: "三角函数",
            cover: "elementary-trigonometry",
            summary: "计算角度和距离",
            icon: .sfSymbol("righttriangle")
        )
    ]
}
