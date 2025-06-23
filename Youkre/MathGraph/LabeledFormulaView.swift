//
//  FunctionDetailView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/18.
//

import SwiftUI

struct LabeledFormulaView: View {
    let title: String
    let latex: String
    
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color(UIColor.secondaryLabel))
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            
            MarkdownListView(
                markdown: latex
            )
            
        }
    }
}



#Preview {
    LabeledFormulaView(
        title: "导数",
        latex: "\\[ y = x^2 \\]",
    )
        .modifier(PaddedCardStyle())
        .padding()
        .background(AppColors.background)
}
