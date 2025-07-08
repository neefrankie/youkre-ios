//
//  IntegralIcon.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/8.
//

import SwiftUI

struct IntegralAreaIcon: View {
    var body: some View {
        Canvas { context, size in
            var curve = Path()
            let w = size.width, h = size.height
            
            curve.move(to: CGPoint(x: 0, y: h * 0.8))
            curve.addCurve(
                to: CGPoint(x: w, y: h*0.2),
                control1: CGPoint(x: w * 0.3, y: h * 1.1),
                control2: CGPoint(x: w * 0.7, y: -0.1)
            )
            
            var area = curve
            area.addLine(to: CGPoint(x: w, y: h))
            area.addLine(to: CGPoint(x: 0, y: h))
            area.closeSubpath()
            
            context.fill(area, with: .color(.white.opacity(0.5)))
            context.stroke(curve, with: .color(.white), lineWidth: 2)
        }
    }
}

#Preview {
    IntegralAreaIcon()
        .frame(width: 24, height: 24)
        .background(.teal)
}
