//
//  TableDataView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/16.
//

import SwiftUI

struct TableDataView: View {
    
    let rows: [[String]]
    var alignment: Alignment = .leading
    
    var body: some View {
        Grid(horizontalSpacing: 1, verticalSpacing: 0) {
            ForEach(rows.indices, id: \.self) { rowIdx in
                let row = rows[rowIdx]
                
                GridRow {
                    ForEach(row.indices, id: \.self) { colIdx in
                        Text("\(row[colIdx])")
                            .frame(
                                minWidth: 50,
                                maxWidth: .infinity,
                                alignment: alignment
                            )
                            .padding(4)
                            .background(AppColors.contentBackground)
                    }
                }
                Divider()
            }
        }
        .background(.gray.opacity(0.2))
        .border(.gray, width: 1)
        .padding()
    }
}

#Preview {
    let rows = [
        ["1月", "1"],
        ["2月", "5"],
        ["3月", "11"],
        ["4月", "20"],
        ["5月", "26"],
        ["6月", "30"],
        ["7月", "30"],
        ["8月", "29"],
        ["9月", "25"],
        ["10月", "19"],
        ["11月", "10"],
        ["12月", "3"],
    ]
    
    TableDataView(
        rows: rows
    )
    
    ScrollView(.horizontal) {
        TableDataView(
            rows: rows,
        )
    }
    
    ScrollView(.horizontal) {
        TableDataView(
            rows: [
                ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月",],
                ["1", "5", "11", "20", "26", "30", "30", "29", "25", "19", "10", "3"],
            ]
        )
    }
    
    
}
