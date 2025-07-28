//
//  BookCardView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/6.
//

import SwiftUI

struct FigureCardView: View {
    let title: String
    let imageName: String
    var isVector: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.headline)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            
            Group {
                if isVector {
                    AspectRatioCardView {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                    }
                } else {
                    AspectRatioCardView {
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                    }
                }
            }
        }
        .modifier(CardStyle())
    }
}

#Preview {
    ScrollView {
        VStack {
            FigureCardView(
                title: "简易微积分",
                imageName: "calculus-made-easy",
                isVector: true,
            )
            FigureCardView(
                title: "初级代数",
                imageName: "elementary-algebra",
                isVector: true
            )
            FigureCardView(
                title: "概率统计入门",
                imageName: "elementary-statistics",
                isVector: true
            )
            FigureCardView(
                title: "三角函数",
                imageName: "elementary-trigonometry",
                isVector: true
            )
        }
        .padding()
    }
}
