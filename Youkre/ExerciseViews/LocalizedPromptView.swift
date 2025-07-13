//
//  LocalizedPromptView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/10.
//

import SwiftUI

struct LocalizedPromptView: View {
    let parts: [PromptPart]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(parts.indices, id: \.self) { i in
                let part = parts[i]
                switch part {
                case .text(let s):
                    Text(s)
                        .frame(maxWidth: .infinity, alignment: .leading)
                case .latex(let ltx):
                    latexView(latex: ltx)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    func latexView(latex: String) -> some View {
        MathView(
            latex: latex,
            fontSize: 20
        )
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    LocalizedPromptView(parts: [
        .text("解这个方程"),
        .latex("x^2 + 3 = 7"),
        .text("求 x = __"),
    ])
}
