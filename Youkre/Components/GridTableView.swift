//
//  GridTableView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/27.
//

import SwiftUI

struct GridTableView: View {
    let data: [String]
    let count: Int
    var horizontal: Bool = true
    
    var body: some View {
        Group {
            if horizontal {
                ScrollView(.horizontal) {
                    LazyHGrid(
                        rows: Array(
                            repeating: .init(.fixed(50)),
                            count: count
                        ),
                        spacing: 1
                    ) {
                        ForEach(data.indices, id: \.self) { i in
                            Text("\(data[i])")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding(8)
                                .background(Color.gray.opacity(0.2))
                        }
                    }
                }
            } else {
                ScrollView {
                    LazyVGrid(
                        columns: Array(
                            repeating: .init(.flexible()),
                            count: count
                        ),
                        spacing: 1) {
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
    GridTableView(
        data: [
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
            "12月", "3"
                      
        ],
        count: 2,
        horizontal: true
    )
    
    GridTableView(
        data: [
            "科学", "34",
            "英语", "90",
            "历史", "87",
            "数学", "34",
            "地理", "55"
        ],
        count: 2
    )
}
