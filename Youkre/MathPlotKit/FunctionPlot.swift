//
//  FunctionPlot.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/18.
//

import SwiftUI

struct FunctionPlot {
    static func plot(
        f: (Double) -> Double,
        center: CGPoint,
        size: CGSize,
        scale: CGFloat
    ) -> Path {
        var path = Path()
        let step = 1.0
        var first = true
        
        for screenX in stride(from: 0.0, through: Double(size.width), by: step) {
            let x = GraphUtils.toCartesianX(
                screenX: screenX,
                center: center,
                scale: scale
            )
            let y = f(x)
            if y.isInfinite || y.isNaN {
                continue
            }
            
            let point = CGPoint(
                x: screenX,
                y: GraphUtils.toScreenY(
                    y: y,
                    center: center,
                    scale: scale,
                )
            )
            if first {
                path.move(to: point)
                first = false
            } else {
                path.addLine(to: point)
            }
        }
        
        return path
    }
    
    static func tangentLine(
        f: (Double) -> Double,
        df: (Double) -> Double,
        x: Double,
        center: CGPoint,
        scale: CGFloat,
    ) -> (Path, Path) {
        let y = f(x)
        if y.isInfinite || y.isNaN {
            return (Path(), Path())
        }
        
        let slope = df(x)
        let lineLength: Double = 2.0
        
        let x1 = x - lineLength
        let x2 = x + lineLength
        let y1 = y - slope * lineLength
        let y2 = y + slope * lineLength
        
        let p1 = CGPoint(
            x: GraphUtils.toScreenX(
                x: x1,
                center: center,
                scale: scale,
            ),
            y: GraphUtils.toScreenY(
                y: y1,
                center: center,
                scale: scale,
            ),
        )
        let p2 = CGPoint(
            x: GraphUtils.toScreenX(
                x: x2,
                center: center,
                scale: scale,
            ),
            y:  GraphUtils.toScreenY(
                y: y2,
                center: center,
                scale: scale,
            ),
        )
        
        var tangent = Path()
        tangent.move(to: p1)
        tangent.addLine(to: p2)
        
        // Tangent point marker
        let px = GraphUtils.toScreenX(
            x: x,
            center: center,
            scale: scale,
        )
        let py = GraphUtils.toScreenY(
            y: y,
            center: center,
            scale: scale,
        )
        let circle = Path(
            ellipseIn: CGRect(
                x: px-3,
                y: py-3,
                width: 6,
                height: 6,
            )
        )
        
        return (tangent, circle)
    }
    
    static func integralArea(
        from x0: Double,
        to x1: Double, // This value changes.
        f: (Double) -> Double,
        center: CGPoint,
        scale: CGFloat,
    ) -> Path {
        // Shaded area under curve from a to currentX
        var shaded = Path()
        // Move to starting point on x axis.
        shaded.move(
            to: CGPoint(
                x: GraphUtils.toScreenX(
                    x: x0,
                    center: center,
                    scale: scale
                ),
                y: center.y
            )
        )

        for x in stride(from: x0, through: x1, by: 0.1) {
            let y = f(x)
            if y.isInfinite || y.isNaN {
                continue
            }
            
            let screenX = GraphUtils.toScreenX(
                x: x,
                center: center,
                scale: scale,
            )
            let screenY = GraphUtils.toScreenY(
                y: y,
                center: center,
                scale: scale,
            )
            // Moving along the curve
            shaded.addLine(
                to: CGPoint(
                    x: screenX,
                    y: screenY
                )
            )
        }
        
        // Move to closing point (which is moving) on the axis.
        shaded.addLine(
            to: CGPoint(
                x: GraphUtils.toScreenX(
                    x: x1,
                    center: center,
                    scale: scale,
                ),
                y: center.y
            )
        )
        shaded.closeSubpath()
        
        return shaded
    }
    
    static func createAxes(center: CGPoint, size: CGSize) -> Path {
        var axes = Path()
        axes.move(
            to: CGPoint(
                x: 0,
                y: center.y
            )
        )
        axes.addLine(
            to: CGPoint(
                x: size.width,
                y: center.y,
            )
        )
        axes.move(
            to: CGPoint(
                x: center.x,
                y: 0
            )
        )
        axes.addLine(
            to: CGPoint(
                x: center.x,
                y: size.height
            )
        )
        
        return axes
    }
}

