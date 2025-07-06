//
//  BookCardView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/6.
//

import SwiftUI

struct VectorImageView: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Image(book.cover)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .aspectRatio(16/9, contentMode: .fit)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            .background(in: Circle())
            .backgroundStyle(.red)
        }
    }
}

#Preview {
    VectorImageView(book: DataStore.bookList[3])
}
