//
//  Article.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/14.
//



struct Article {
    let book: Book
    let toc: [TocEntry]
    let tocIndex: Int
    let currentEntry: TocEntry
    let previousPage: TocEntry?
    let nextPage: TocEntry?
}
