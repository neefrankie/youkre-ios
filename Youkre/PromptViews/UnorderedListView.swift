//
//  UnorderedListView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/27.
//


import SwiftUI

struct UnorderedListView: View {
    let items: [String]
    
    var body: some View {
        ForEach(items.indices, id: \.self) { idx in
            HStack(alignment: .top) {
                Text("•")
                Text(TextUtils.attributed(from: items[idx]))
            }
        }
    }
}
