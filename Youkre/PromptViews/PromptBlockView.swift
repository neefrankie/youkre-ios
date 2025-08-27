//
//  PromptBlockView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/14.
//

import SwiftUI

struct PromptBlockView: View {
    let block: PromptBlock
    
    var body: some View {
        switch block {
        case .text(let string):
            Text(string)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                
        case .latex(let latex):
            MathView(
                latex: latex,
            )
            .fixedSize(horizontal: false, vertical: true)
        case .image(let name):
            HStack {
                Spacer()
                Image(name)
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
            .frame(maxHeight: 300)
        case .table(let table):
            if table.horizontal {
                ScrollView(.horizontal) {
                    TableDataView(
                        rows: table.data,
                        
                    )
                }
            } else {
                TableDataView(
                    rows: table.data,
                    
                )
            }
        case .bullet(let text):
            HStack(alignment: .top) {
                Text("•").bold()
                Text(text)
            }
        case .newline:
            Spacer().frame(height: 8)
        }
    }
}

#Preview {
    PromptBlockView(
        block: .image("triangle-exercise-1")
    )
}
