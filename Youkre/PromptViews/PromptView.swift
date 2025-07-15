//
//  PromptView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/14.
//

import SwiftUI

struct PromptView: View {
    let blocks: [PromptBlock]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(blocks.indices, id: \.self) { i in
                PromptBlockView(block: blocks[i])
            }
        }
    }
}

#Preview {
    PromptView(
        blocks: [
            .text("Compare the functions:"),
            .newline,
            .table(rows: [
                ["Function", "Expression"],
                ["Linear", "y = mx + b"],
                ["Quadratic", "y = ax² + bx + c"]
            ]),
            .newline,
            .latex("f(x) = 2x^2 + 3x + 1"),
            .text("What type of function is this?"),
            .bullet("Item 1")
        ]
    )
    .padding()
}
