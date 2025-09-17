//
//  MarkdownView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/17.
//

import SwiftUI

struct MarkdownView: View {
    let markdown: String
    var spacing: CGFloat = 16
    var latexFontSize: CGFloat = 24
    
    @State private var isLoading = true
    @State private var blocks: [MarkdownBlock] = []
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else {
                MarkdownListView(
                    blocks: blocks,
                    spacing: spacing,
                    latexFontSize: latexFontSize
                )
            }
        }
        .onAppear {
            parse()
        }
    }
    
    func parse() {
        isLoading = true
        self.blocks = MarkdownParser.parse(markdown)
        isLoading = false
    }
}


#Preview {
    let sampleMarkdown = #"""
    本题要求将周长 L 的热膨胀关系转化为直径 D 的变化率。

    ### 步骤 1：建立 D 与 L 的关系

    铁箍是圆形，周长与直径关系为：

    \begin{align*}
    L &= \pi D \\
    D &= \frac{L}{\pi}
    \end{align*}

    ### 步骤 2：将 L 的表达式代入

    已知

    \[ L = l_t \bigl[1 + 0.000012(T-t)\bigr]\]

    所以：

    \[
    D = \frac{1}{\pi} \cdot l_t \bigl[1 + 0.000012(T-t)\bigr]
    \]

    这里 𝑙ₜ, π, t 都是常数，T 是变量。

    ### 步骤 3：对 D 关于 T 求导

    \begin{align*}
    \frac{dD}{dT} &= \frac{1}{\pi} \cdot l_t \cdot \frac{d}{dT} [1 + 0.000012(T-t)] \\
    &= \frac{1}{\pi} \cdot l_t \cdot 0.000012 \\
    &= \frac{l_t}{\pi} \times 0.000012
    \end{align*}

    ### 物理意义解释

    - dD / dT 表示温度每升高 1°C，铁箍直径增加的量。

    - 结果是一个常数，说明直径随温度线性膨胀。

    - 𝑙ₜ / π  就是参考温度 t 时的直径 Dₜ，所以

    \[ \frac{dD}{dT} = D_t \times 0.000012 \]

    即“直径的膨胀率 = 原直径 × 线膨胀系数”，符合物理规律。
    """#
    ScrollView {
        MarkdownView(markdown: sampleMarkdown)
            .padding()
    }
    
}
