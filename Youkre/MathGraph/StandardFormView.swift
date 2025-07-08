//
//  StandardFormView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/22.
//

import SwiftUI

struct StandardFormView: View {
    let derivative: String
    let integral: String
    
    var body: some View {
        VStack(spacing: 32) {
            
            LabeledFormulaView(
                title: "导数",
                latex: derivative,
            )
            
            LabeledFormulaView(
                title: "积分",
                latex: integral,
            )
        }
    }
}

#Preview {
    let definition = StandardForm.list[5]
    StandardFormView(
        derivative: definition.derivativeLatex,
        integral: definition.integralLatex,
    )
    .modifier(PaddedCardStyle())
    .padding()
    .background(AppColors.background)
}
