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
    
    var text: String {
        body.joined(separator: "\n\n")
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(slug)
    }
}

struct TableOfContents: Codable {
    let title: String
    let items: [TocEntry]
}

struct TocEntry: Identifiable, Codable, Hashable {
    let id: String
    let slug: String
    let text: String
    let title: String
    let subtitle: String
    
    static var continued = TocEntry(
        id: "to-be-continued",
        slug: "",
        text: "未完待续...",
        title: "",
        subtitle: ""
    )
}

struct ChapterParams: Hashable {
    let book: Book
    let toc: [TocEntry]
    let currentIndex: Int
    let currentEntry: TocEntry
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(currentEntry.slug)
    }
    
    var hasNext: Bool {
        if toc.isEmpty {
            return false
        }
        var lastIdx = toc.count - 1
        if toc.last == TocEntry.continued {
            lastIdx = lastIdx - 1
        }
        return currentIndex >= 0 && currentIndex < lastIdx
    }
    
    var hasPrevious: Bool {
        if toc.isEmpty {
            return false
        }
        
        return currentIndex > 0 && currentIndex < toc.count
    }
    
    func nextChapter() -> ChapterParams? {
        if !hasNext {
            return nil
        }
        
        return ChapterParams(
            book: book,
            toc: toc,
            currentIndex: currentIndex+1,
            currentEntry: toc[currentIndex+1]
        )
    }
    
    func previousChapter() -> ChapterParams? {
        if !hasPrevious {
            return nil
        }
        
        return ChapterParams(
            book: book,
            toc: toc,
            currentIndex: currentIndex-1,
            currentEntry: toc[currentIndex-1]
        )
    }
}
