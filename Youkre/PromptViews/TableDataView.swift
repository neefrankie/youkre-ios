//
//  TableDataView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/16.
//

import SwiftUI

struct TableDataView: View {
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
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 1) {
                ForEach(data.indices, id: \.self) { i in
                    Text("\(data[i])")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                }
            }
        }
        
        ScrollView(.horizontal) {
            LazyHGrid(rows: Array(repeating: .init(.fixed(50)), count: 2), spacing: 1) {
                ForEach(data.indices, id: \.self) { i in
                    Text("\(data[i])")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                }
            }
        }
    }
}

#Preview {
    let data: [String] = [
        
    ]
    TableDataView()
}
