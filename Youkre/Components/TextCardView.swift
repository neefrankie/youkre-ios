//
//  TextCardView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/29.
//

import SwiftUI

struct TextCardView: View {
    let title: String
    var summary: String = ""
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(summary)
                    .font(.body)
                    .foregroundColor(.secondary)
                    
            }
            
            Spacer()
        }
        .modifier(PaddedCardStyle())
    }
}
