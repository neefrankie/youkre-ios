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
        VStack(
            spacing: 4
        ) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color(UIColor.secondaryLabel))
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            
            MathView(
                equation: latex
            )
        }
        
    }
}



#Preview {
    LabeledFormulaView(
        title: "导数",
        latex: "y = x^2",
    )
}
