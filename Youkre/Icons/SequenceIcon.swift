//
//  SequenceIcon.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/8.
//

import SwiftUI

struct SequenceIcon: View {
    var body: some View {
        Canvas { context, size in
            let dotCount = 5
            let spacing = size.width / CGFloat(dotCount + 1)
            let radius: CGFloat = 2.5
            
            for i in 1...dotCount {
                let x = CGFloat(i) * spacing
                let y = size.height * 0.5 + sin(CGFloat(i)) * 5
                let dot = Path(
                    ellipseIn: CGRect(
                        x: x - radius,
                        y: y - radius,
                        width: radius * 2,
                        height: radius*2
                    )
                )
                context.fill(dot, with: .color(.white))
            }
        }
    }
}

#Preview {
    SequenceIcon()
        .frame(width: 24, height: 24)
        .modifier(TocIconStyle())
}
