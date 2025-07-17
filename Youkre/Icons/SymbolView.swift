//
//  SymbolView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/17.
//

import SwiftUI

struct SymbolView: View {
    let icon: Icons
    let backgroundColor: Color = .gray.opacity(0.8)
    
    var body: some View {
        Group {
            if let sf = icon.sfSymbol, !sf.isEmpty {
                IconBoxView(background: backgroundColor) {
                    Image(systemName: sf)
                        .font(.system(size: 24))
                }
            }
            
            if let latex = icon.latex, !latex.isEmpty {
                IconBoxView(background: .gray) {
                    LatexIconView(
                        latex: latex,
                    )
                }
            }
            
            let letter = String(entry.keywords.prefix(1)).uppercased()
            IconBoxView(background: .secondary) {
                Text(letter)
                    .font(.system(size: 20, weight: .bold))
            }
        }
    }
}

#Preview {
    SymbolView(
        icon: Icons(
            predefined: "integral"
        )
    )
}
