//
//  Book.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/3/13.
//
import SwiftUI

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

struct TocEntry: Identifiable, Codable, Hashable {
    let id: String
    let slug: String
    let text: String
    let summary: String
    let title: String
    var children: [TocEntry] = []
    
    func toDisplayEntry(level: Int = 0) -> TocDisplayEntry {
        return TocDisplayEntry(
            id: self.id.isEmpty ? UUID().uuidString : self.id,
            slug: self.slug,
            text: self.text,
            summary: self.summary,
            title: self.title,
            level: level
        )
    }
}

struct TocDisplayEntry: Identifiable, Hashable {
    let id: String
    let slug: String
    let text: String
    let summary: String
    let title: String
    let level: Int
}

struct TableOfContents: Codable {
    let title: String
    let items: [TocEntry]
    
    func flattenItems(level: Int = 0) -> [TocDisplayEntry] {
        return TableOfContents.flattenToc(self.items)
    }
    
    static func flattenToc(_ entries: [TocEntry], level: Int = 0) -> [TocDisplayEntry] {
        var result: [TocDisplayEntry] = []
        
        for entry in entries {
            result.append(entry.toDisplayEntry(level: level))
            
            result += flattenToc(entry.children, level: level+1)
        }
        
        return result
    }
}

struct ChapterParams: Hashable {
    let book: Book
    let current: TocDisplayEntry
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(current.slug)
    }
}
