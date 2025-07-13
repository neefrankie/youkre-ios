//
//  Book.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/3/13.
//

struct Book: Codable, Identifiable, Hashable {
    let id: String
    let slug: String
    let title: String
    let cover: String
    let body: [String]
    var isVector: Bool = false
    
    var text: String {
        body.joined(separator: "\n\n")
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(slug)
    }
    
    static let bookList: [Book] = [
        Book(
            id: "5bd2c24bd901b5a9",
            slug: "calculus-made-easy",
            title: "简易微积分",
            cover: "calculus-made-easy",
            body: [
                "简单易懂的微积分"
            ]
        ),
        Book(
            id: "6b927048e42cc585",
            slug: "elementary-algebra",
            title: "初级代数",
            cover: "elementary-algebra",
            body: [
                "用字母、数字和符号来“玩”的游戏"
            ],
            isVector: true,
        ),
        Book(
            id: "ad7dd3035d82eda3",
            slug: "elementary-statistics",
            title: "概率统计入门",
            cover: "elementary-statistics",
            body: ["预测事情发生的可能性，找出规律"],
            isVector: true
        ),
        Book(
            id: "9b08c5f3f19338c4",
            slug: "elementary-trigonometry",
            title: "三角函数",
            cover: "elementary-trigonometry",
            body: [
                "计算角度和距离"
            ],
            isVector: true
        )
    ]
}

struct ChapterLink: Hashable, Codable {
    let bookSlug: String
    let chapterSlug: String
    
    static let algebraIntroMul = ChapterLink(
        bookSlug: Book.bookList[1].slug,
        chapterSlug: "introduction-multiply"
    )
    
    static let calChp1 = ChapterLink(
        bookSlug: Book.bookList[0].slug,
        chapterSlug: "1"
    )
    
    static let calChp2 = ChapterLink(
        bookSlug: Book.bookList[0].slug,
        chapterSlug: "2"
    )
    
    static let calChp3 = ChapterLink(
        bookSlug: Book.bookList[0].slug,
        chapterSlug: "3"
    )
    
    static let calChp4 = ChapterLink(
        bookSlug: Book.bookList[0].slug,
        chapterSlug: "4"
    )
}
