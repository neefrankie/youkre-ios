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
    
    //    func symbolView(for entry: TocDisplayEntry) -> some View {
    //        if let sf = entry.icons.sfSymbol, !sf.isEmpty {
    //            return AnyView(
    //                IconBoxView(background: iconBackgroundColor(for: entry)) {
    //                    Image(systemName: sf)
    //                        .font(.system(size: 24))
    //                }
    //            )
    //        }
    //
    //        if let key = entry.icons.predefined, let viewBuilder = IconStore.symbolViewMap[key] {
    //            return viewBuilder()
    //        }
    //
    //        if let latex = entry.icons.latex, !latex.isEmpty {
    //            return AnyView(
    //                IconBoxView(background: .gray) {
    //                    LatexIconView(
    //                        latex: latex,
    //                    )
    //                }
    //            )
    //        }
    //
    //        let letter = String(entry.keywords.prefix(1)).uppercased()
    //        return AnyView(
    //            IconBoxView(background: .secondary) {
    //                Text(letter)
    //                    .font(.system(size: 20, weight: .bold))
    //            }
    //        )
    //    }
        
    //    func iconBackgroundColor(for entry: TocDisplayEntry) -> Color {
    //        let palette: [Color] = [
    //            .blue, .green, .orange, .purple, .pink, .indigo, .teal, .cyan
    //        ]
    //
    //        let index = abs(entry.slug.hashValue) % palette.count
    //
    //        return palette[index].opacity(0.8)
    //    }
}
