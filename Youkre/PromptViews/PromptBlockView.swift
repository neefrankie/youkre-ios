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
            latexView(latex: latex)
        case .image(let name):
            HStack {
                Spacer()
                Image(name)
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
            .frame(maxHeight: 300)
        case .table(let data, let layout):
            tableView(data: data, layout: layout)
        case .bullet(let text):
            HStack(alignment: .top) {
                Text("•").bold()
                Text(text)
            }
        case .newline:
            Spacer().frame(height: 8)
        }
    }
    
    func latexView(latex: String) -> some View {
        MathView(
            latex: latex,
            fontSize: 20
        )
        .fixedSize(horizontal: false, vertical: true)
    }
    
    func tableView(data: [String], layout: TableLayout) -> some View {
        Group {
            switch layout {
            case .rows(let count):
                ScrollView(.horizontal) {
                    LazyHGrid(rows: Array(repeating: .init(.fixed(50)), count: count), spacing: 1) {
                        ForEach(data.indices, id: \.self) { i in
                            Text("\(data[i])")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding(8)
                                .background(Color.gray.opacity(0.2))
                        }
                    }
                }
            case .columns(let count):
                ScrollView {
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: count), spacing: 1) {
                        ForEach(data.indices, id: \.self) { i in
                            Text("\(data[i])")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(8)
                                .background(Color.gray.opacity(0.2))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let data: [String] = [
        "1月", "1",
        "2月", "5",
        "3月", "11",
        "4月", "20",
        "5月", "26",
        "6月", "30",
        "7月", "30",
        "8月", "29",
        "9月", "25",
        "10月", "19",
        "11月", "10",
        "12月", "3",
    ]
    PromptBlockView(
        block: .table(data: data, layout: .rows(2))
    )
    
    PromptBlockView(
        block: .image(name: "triangle-exercise-1")
    )
}
