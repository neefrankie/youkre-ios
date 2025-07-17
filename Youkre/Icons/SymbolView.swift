//
//  SymbolView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/17.
//

import SwiftUI

struct SymbolView: View {
    let icon: IconSymbol
    var backgroundColor: Color = .gray.opacity(0.8)
    
    var body: some View {
        switch icon {
        case .sfSymbol(let sfSymbol):
            IconBoxView(background: backgroundColor) {
                Image(systemName: sfSymbol)
                    .font(.system(size: 24))
            }
        case .latex(let name):
            // Search the predefined shape by name as key.
            if let viewBuilder = IconStore.symbolViewMap[name] {
                viewBuilder()
            } else {
                // else rener the name as latex string.
                IconBoxView(background: backgroundColor) {
                    LatexIconView(
                        latex: name,
                    )
                }
            }
        case .text(let letter):
            IconBoxView(background: backgroundColor) {
                Text(letter)
                    .font(.system(size: 20, weight: .bold))
            }
        }
    }
}

#Preview {
    SymbolView(
        icon: .latex("integral")
    )
}
