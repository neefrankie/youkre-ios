//
//  LadderMoveIcon.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/8.
//

import SwiftUI

struct LadderMoveIcon: View {
    var body: some View {
        Canvas { context, size in
            var path = Path()
            let w = size.width, h = size.height
            
            path.move(
                to: CGPoint(x: 0, y: 0)
            )
            path.addLine(to: CGPoint(x: 0, y: h))
            path.addLine(to: CGPoint(x: w, y: h))
            path.closeSubpath()
            
            context.stroke(
                path,
                with: .color(.white),
                lineWidth: 2
            )
        }
    }
}

#Preview {
    IconBoxView {
        LadderMoveIcon()
    }

}
