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
            .table(GridTable(
                data: [
                    ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月",],
                    ["1", "5", "11", "20", "26", "30", "30", "29", "25", "19", "10", "3"],
                ],
                horizontal: true
            )),
            .latex("f(x) = 2x^2 + 3x + 1"),
            .bullet("Item 1"),
            .text("""
                在年终考试中，乔乔的成绩如下：

                科学 34  
                英语 90  
                历史 87  
                数学 34  
                地理 55  

                乔乔的成绩众数是多少？
                """),
            .image("triangle-exercise-5-a"),
            .text("图中显示的是一个菱形。如果画出菱形的对角线，形成的四个三角形是：")
        ]
    )
    .padding()
}
