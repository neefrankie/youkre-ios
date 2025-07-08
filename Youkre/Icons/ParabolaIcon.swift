//
//  ParabolaView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/8.
//

import SwiftUI

struct ParabolaIcon: View {
    var body: some View {
        Canvas { context, size in
            var path = Path()
            let w = size.width, h = size.height
            
            path.move(
                to: CGPoint(x: 0, y: h * 0.5)
            )
            path.addQuadCurve(
                to: CGPoint(x: w, y: 0),
                control: CGPoint(x: w * 0.5, y: h*1.5)
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
    ParabolaIcon()
        .frame(width: 24, height: 24)
        .background(.teal)
}
