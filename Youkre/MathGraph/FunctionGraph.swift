//
//  FunctionGraph.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/18.
//

import SwiftUI

struct FunctionGraph: View {
    let f: (Double) -> Double
    let df: (Double) -> Double
    let currentX: Double
    let scale: CGFloat
    let showTangent: Bool
    let showIntegral: Bool
    let xRange: (Double, Double)
    
    var body: some View {
        Canvas { context, size in
            let center = CGPoint(
                x: size.width / 2,
                y: size.height / 2
            )
            
            // Axes
            context.stroke(
                GraphUtils.createAxes(
                    center: center,
                    size: size
                ),
                with: .color(AppColors.graphAxes),
                lineWidth: 1
            )
            
            // Shaded area under curve from a to currentX
            if showIntegral {
                context.fill(
                    IntegralArea.plot(
                        from: xRange.0,
                        to: currentX,
                        f: f,
                        center: center,
                        scale: scale,
                    ),
                    with: .color(
                        .teal.opacity(0.3)
                    )
                )
            }
            

            // Draw the curve
            context.stroke(
                FunctionPlot.plot(
                    f: f,
                    center: center,
                    size: size,
                    scale: scale,
                ),
                with: .color(.teal),
                lineWidth: 2
            )
            
            
            
            if showTangent {
                let (line, marker) = TangentLine.plot(
                    f: f,
                    df: df,
                    x: currentX,
                    center: center,
                    scale: scale,
                )
                context.stroke(
                    line,
                    with: .color(.red),
                    lineWidth: 2
                )
                context.fill(
                    marker,
                    with: .color(.red)
                )
            }
        }
    }
}

#Preview {
    FunctionGraph(
        f: {x in x * x},
        df: {x in 2 * x},
        currentX: 5,
        scale: 20,
        showTangent: true,
        showIntegral: true,
        xRange: (-5, 5),
    )
    .frame(width: 300, height: 300)
    .border(.black)
}
