//
//  HomeView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/3/16.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(DataStore.bookList) { book in
                        NavigationLink(value: book) {
                            BookCardView(book: book)
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
    }
}


#Preview {
    @Previewable @StateObject var themeManager = ThemeManager.shared
    
    HomeView()
        .environmentObject(themeManager)
        .preferredColorScheme(themeManager.preferredColorScheme)
        .background(AppColors.background)
}
