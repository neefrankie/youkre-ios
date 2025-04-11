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
                ForEach(DataStore.bookList) { book in
                    NavigationLink(value: book) {
                        CardView(
                            image: Image(book.slug),
                            title: book.title,
                            subtitle: book.text
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationDestination(for: Book.self) { book in
                TOCView(book: book)
            }
            .navigationTitle(Config.appName)
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

#Preview {
    HomeView()
}
