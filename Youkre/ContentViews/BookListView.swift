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
                    ForEach(Book.bookList) { book in
                        NavigationLink(value: book) {
                            bookCard(book: book)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationDestination(for: Book.self) { book in
                TocView(book: book)
            }
            .navigationTitle(Config.appName)
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .background(AppColors.background)
    }
    
    func bookCard(book: Book) -> some View {
        HStack(alignment: .center, spacing: 16) {
            SymbolView(
                icon: book.icon,
                backgroundColor: iconBackgroundColor(for: book)
            )
            
            VStack(alignment: .leading, spacing: 16) {
                Text(book.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(book.summary)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .modifier(PaddedCardStyle())
    }
    
    func iconBackgroundColor(for book: Book) -> Color {
        let palette: [Color] = [
            .blue, .green, .orange, .purple, .pink, .indigo, .teal, .cyan
        ]
        
        let index = abs(book.slug.hashValue) % palette.count
        
        return palette[index].opacity(0.8)
    }
}


#Preview {
    @Previewable @StateObject var themeManager = ThemeManager.shared
    
    BookListView()
        .environmentObject(themeManager)
        .preferredColorScheme(themeManager.preferredColorScheme)
}
