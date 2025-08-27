//
//  HomeView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/3/16.
//

import SwiftUI

struct BookListView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(Book.bookList) { course in
                        NavigationLink(value: course) {
                            bookCard(course: course)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationDestination(for: Book.self) { course in
                TocView(course: course)
            }
            .navigationDestination(for: ChapterLink.self) { params in
                ChapterView(params: params)
            }
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .background(AppColors.background)
    }
    
    func bookCard(course: Book) -> some View {
        HStack(alignment: .center, spacing: 16) {
            SymbolView(
                icon: course.icon,
                backgroundColor: iconBackgroundColor(for: course)
            )
            
            VStack(alignment: .leading, spacing: 16) {
                Text(course.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(course.summary)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .modifier(PaddedCardStyle())
    }
    
    func iconBackgroundColor(for course: Book) -> Color {
        let palette: [Color] = [
            .blue, .green, .orange, .purple, .pink, .indigo, .teal, .cyan
        ]
        
        let index = abs(course.slug.hashValue) % palette.count
        
        return palette[index].opacity(0.8)
    }
}


#Preview {
    @Previewable @StateObject var themeManager = ThemeManager.shared
    
    BookListView()
        .environmentObject(themeManager)
        .preferredColorScheme(themeManager.preferredColorScheme)
}
