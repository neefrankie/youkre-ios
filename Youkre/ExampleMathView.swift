//
//  ExampleMathView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/5/28.
//

import SwiftUI
import LaTeXSwiftUI


struct ExampleMathView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Math formula:")
            LaTeX("$\\frac{a}{b} = c$")
                .frame(height: 50)
            
            LaTeX("Hello, $\\LaTeX$!")
        }
        .padding()
    }
}

#Preview {
    ExampleMathView()
}
