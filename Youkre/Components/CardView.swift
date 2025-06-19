//
//  BookCardView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/3/16.
//

import SwiftUI

struct CardView: View {
    let image: Image?
    let title: String
    let subtitle: String
    
    init(
        image: Image? = nil,
        title: String = "",
        subtitle: String = ""
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let img = image {
                img.resizable()
                    .scaledToFit()
                    .cornerRadius(12)
            }
            
            VStack(
                alignment: .leading,
                spacing: 8
            ) {
                Text(title)
                    .font(.headline)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .center
                    )
                
                Text(subtitle)
                    .font(.subheadline)
            }
            .padding()
        }
        .modifier(CardStyle())
        .shadow(radius: 6)
        .padding(.horizontal)
    }
}

#Preview {
    let book = DataStore.bookList[0]
    
    CardView(
        image: Image(book.slug),
        title: book.title,
        subtitle: book.text
    )
}
