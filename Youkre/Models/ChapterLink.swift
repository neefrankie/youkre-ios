//
//  Book.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/3/13.
//

struct ChapterLink: Hashable, Codable {
    let courseSlug: String
    let chapterSlug: String
    
    static let algebraIntro = ChapterLink(
        courseSlug: Book.bookList[1].slug,
        chapterSlug: "introduction"
    )
    
    static let algebraMul = ChapterLink(
        courseSlug: Book.bookList[1].slug,
        chapterSlug: "introduction-multiply"
    )
    
    static let algebraOpOrder = ChapterLink(
        courseSlug: Book.bookList[1].slug,
        chapterSlug: "operation-order-pemdas"
    )
    
    static let statsChp1Sec1 = ChapterLink(
        courseSlug: Book.bookList[2].slug,
        chapterSlug: "central-measures"
    )
    
    static let trigChp1Sec1 = ChapterLink(
        courseSlug: Book.bookList[3].slug,
        chapterSlug: "triangle"
    )
    
    static let cme1 = ChapterLink(
        courseSlug: Book.bookList[0].slug,
        chapterSlug: "1"
    )
    
    static let cme2 = ChapterLink(
        courseSlug: Book.bookList[0].slug,
        chapterSlug: "2"
    )
    
    static let cme3 = ChapterLink(
        courseSlug: Book.bookList[0].slug,
        chapterSlug: "3"
    )
    
    static let cme4a = ChapterLink(
        courseSlug: Book.bookList[0].slug,
        chapterSlug: "4-1"
    )
    
    static let cme4b = ChapterLink(
        courseSlug: Book.bookList[0].slug,
        chapterSlug: "4-2"
    )
}
