//
//  GraphUtils.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/18.
//

import CoreGraphics

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
}
