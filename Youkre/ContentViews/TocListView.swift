//
//  TocListView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/9/15.
//


import SwiftUI

struct TocListView: View {
    var course: Course
    var entries: [TocDisplayEntry]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(entries) { entry in
                    if entry.slug.isEmpty {
                        Text(entry.title)
                            .font(.title)
                            .padding(.top, 32)
                    } else {
                        NavigationLink(
                            value: ChapterLink(
                                courseSlug: course.slug,
                                chapterSlug: entry.slug,
                            )
                        ) {
                            TextCardView(
                                title: entry.title,
                                summary: entry.summary
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding()
        }
        
    }
}
