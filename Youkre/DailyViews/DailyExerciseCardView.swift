//
//  DailyExerciseCardView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/22.
//

import SwiftUI

struct DailyExerciseCardView: View {
    let question: String
    
    var body: some View {
        MarkdownView(markdown: question)
            .modifier(PaddedCardStyle())
    }
}

#Preview {
    let prompts =  #"""
已知温度为 T 时铁棒的长度 L 为

\[ L = l_t\bigl[1 + 0.000012(T-t)\bigr] \]

其中 𝑙ₜ 是温度为 t 时的长度， 0.000012 是铁的线膨胀系数。

把铁棒折成圆环铁箍，加热后膨胀，套在轮子上，冷却收缩后紧箍住轮子。设 D 为温度 T 时圆环的直径，求直径 D  随温度 T 的变化率 

\[ \frac{dD}{dT} \]
"""#
    
    ScrollView {
        VStack {
            DailyExerciseCardView(
                question: prompts
            )
            
            NavigationLink(value: "a") {
                DailyExerciseCardView(
                    question: prompts
                )
            }
            
            Text(prompts)
            
            NavigationLink(value: "b") {
                Text(prompts)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
    }
}
