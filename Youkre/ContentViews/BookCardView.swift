//
//  BookCardView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/6.
//

import SwiftUI

struct BookCardView: View {
    let book: Book
    
    var body: some View {
        VStack(spacing: 0) {
            Text(book.title)
                .font(.headline)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            
            Group {
                if book.isVector {
                    AspectRatioCardView {
                        Image(book.slug)
                            .resizable()
                            .scaledToFit()
                    }
                } else {
                    AspectRatioCardView {
                        Image(book.slug)
                            .resizable()
                            .aspectRatio(16/9, contentMode: .fill)
                    }
                }
            }
        }
        .modifier(CardStyle())
    }
}

#Preview {
    BookCardView(book: DataStore.bookList[3])
}
