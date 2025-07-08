//
//  FunctionIcon.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/8.
//

import SwiftUI

struct FunctionIcon: View {
    var body: some View {
        Canvas { context, size in
            var path = Path()
            let w = size.width, h = size.height
            
            path.move(
                to: CGPoint(x: 0, y: h * 0.9)
            )
            path.addCurve(
                to: CGPoint(x: w, y: h*0.1),
                control1: CGPoint(x: w*0.3, y: h*1.2),
                control2: CGPoint(x: w*0.7, y: -0.2)
            )
            
            context.stroke(
                path,
                with: .color(.white),
                lineWidth: 2
            )
        }
    }
}

#Preview {
    FunctionIcon()
        .frame(width: 24, height: 24)
        .modifier(TocIconStyle())
}
