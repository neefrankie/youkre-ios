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
        VStack {
            Text(book.title)
                .font(.headline)
                .padding()
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            
            Group {
                if book.isVector {
                    AspectRatioCardView() {
                        Image(book.slug)
                            .resizable()
                            .scaledToFit()
                    }
                } else {
                    Image(book.slug)
                        .resizable()
                        .aspectRatio(16/9, contentMode: .fill)
                }
            }
        }
        .modifier(CardStyle())
        .padding()
    }
}

#Preview {
    BookCardView(book: DataStore.bookList[3])
}
