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
}

struct ChapterParams: Hashable {
    let book: Book
    let current: TocDisplayEntry
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(current.slug)
    }
}
