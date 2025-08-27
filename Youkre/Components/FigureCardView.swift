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
    var fit: Bool = false
    var ratio: CGFloat = 16/9
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            
            Group {
                if fit {
                    AspectRatioCardView(
                        ratio: ratio,
                    ) {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                    }
                } else {
                    AspectRatioCardView(
                        ratio: ratio,
                    ) {
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
    Grid {
        GridRow {
            FigureCardView(
                title: "简易微积分",
                imageName: "calculus-made-easy",
                fit: true,
                ratio: 1
            )
            
            FigureCardView(
                title: "初级代数",
                imageName: "elementary-algebra",
                fit: true
            )
        }
        
        GridRow {
            FigureCardView(
                title: "概率统计入门",
                imageName: "elementary-statistics",
                fit: true
            )
            FigureCardView(
                title: "三角函数",
                imageName: "elementary-trigonometry",
                fit: true
            )
        }
    }
    .padding()
}
