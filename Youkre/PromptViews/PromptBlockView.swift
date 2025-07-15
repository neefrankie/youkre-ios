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
        case .latex(let latex):
            latexView(latex: latex)
        case .iamge(let name):
            Image(name)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)
        case .table(let rows):
            gridView(rows: rows)
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
    
    func tableView(rows: [[String]]) -> some View {
        Grid(alignment: .leading) {
            ForEach(rows.indices, id: \.self) { rowIndex in
                GridRow {
                    ForEach(rows[rowIndex].indices, id: \.self) { colIndex in
                        Text(rows[rowIndex][colIndex])
                            
                    }
                }
                .background(.green)
            }
        }
        .frame(maxWidth: .infinity)
        .background(.red)
        
    }
    
    func gridView(rows: [[String]]) -> some View {
        let maxColumns = rows.map { $0.count }.max() ?? 0
        let columns = Array(repeating: GridItem(.flexible()), count: maxColumns)
        
        return LazyVGrid(columns: columns, alignment: .leading) {
            ForEach(rows.indices, id: \.self) { rowIdx in
                let row = rows[rowIdx]
                
                ForEach(0..<maxColumns, id: \.self) { colIndex in
                    if colIndex < row.count {
                        Text(row[colIndex])
                            .padding(.vertical, 4)
                    } else {
                        // 如果当前行没有足够的列，则填充一个空单元格
                        Color.clear.frame(height: 0)
                    }
                }
            }
        }
        
    }
}

#Preview {
    PromptBlockView(
        block: .table(rows: [
            ["Function", "Expression"],
            ["Linear", "y = mx + b"],
            ["Quadratic", "y = ax² + bx + c"]
        ])
    )
    
    PromptBlockView(
        block: .bullet("Item 1")
    )
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(.red)
}
