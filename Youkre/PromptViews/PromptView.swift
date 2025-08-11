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
            .table(Table(
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
                    "12月", "3",
                ],
                rows: 2
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
