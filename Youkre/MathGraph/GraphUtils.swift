//
//  GraphUtils.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/18.
//

import SwiftUI

struct GraphUtils {
    static func toCartesianX(screenX: Double, center: CGPoint, scale: CGFloat) -> Double {
        return (screenX - Double(center.x)) / Double(scale)
    }
    
    static func toCartesianY(screenY: Double, center: CGPoint, scale: CGFloat) -> Double {
        return -(screenY - Double(center.y)) / Double(scale)
    }
    
    static func toScreenX(x: Double, center: CGPoint, scale: CGFloat) -> CGFloat {
        return CGFloat(x) * scale + center.x
    }
    
    static func toScreenY(y: Double, center: CGPoint, scale: CGFloat) -> CGFloat {
        return -(CGFloat(y) * scale - center.y)
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
