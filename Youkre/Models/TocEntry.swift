//
//  TocEntry.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/8.
//

import Foundation

struct TocEntry: Identifiable, Codable {
    let id: String
    let slug: String
    let title: String
    let summary: String
    let keywords: String
    let icons: Icons
    var children: [TocEntry] = []
    
    func toDisplayEntry(level: Int = 0) -> TocDisplayEntry {
        return TocDisplayEntry(
            id: self.id.isEmpty ? UUID().uuidString : self.id,
            slug: self.slug,
            title: self.title,
            summary: self.summary,
            keywords: self.keywords,
            icons: self.icons,
            level: level
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "hex_id"
        case slug = "slug"
        case title = "title"
        case summary = "summary"
        case keywords = "keywords"
        case icons = "icons"
        case children = "children"
    }
}

// Use Hashable so that it can be used in NavigationLink.
// 默认即使你没有手动写 ==，Swift 通常会为你自动合成 Equatable 和 Hashable 的实现（只要所有属性都是 Hashable 类型）。
// 但如果你自己实现了 hash(into:)，Swift 就不会自动合成 ==，这时你就必须手动实现 Equatable
struct TocDisplayEntry: Identifiable, Hashable {
    let id: String
    let slug: String
    let title: String
    let summary: String
    let keywords: String
    let icons: Icons
    let level: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
        hasher.combine(title)
    }
    
    static func == (lhs: TocDisplayEntry, rhs: TocDisplayEntry) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title
    }
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
