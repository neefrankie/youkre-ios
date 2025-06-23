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
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            
            Canvas { context, size in
                let center = CGPoint(
                    x: size.width / 2,
                    y: size.height / 2
                )
                
                // Axes
                context.stroke(
                    FunctionPlot.createAxes(
                        center: center,
                        size: size
                    ),
                    with: .color(AppColors.graphAxes),
                    lineWidth: 1
                )
                
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
                
                // Shaded area under curve from a to currentX
                if showIntegral {
                    context.fill(
                        FunctionPlot.integralArea(
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
                
                if showTangent {
                    let (line, marker) = FunctionPlot.tangentLine(
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
            .frame(width: size, height: size)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    let function = ReciprocalFunction()
    
    FunctionGraph(
        f: function.f,
        df: function.df,
        currentX: 5,
        scale: 20,
        showTangent: true,
        showIntegral: true,
        xRange: (-5, 5),
    )
}
