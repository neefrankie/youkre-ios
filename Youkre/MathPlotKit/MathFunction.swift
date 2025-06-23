//
//  MathFunction.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/21.
//

import Foundation

// MARK: - 基础函数协议
protocol MathFunction {
    func f(_ x: Double) -> Double
    func df(_ x: Double) -> Double
}

// MARK: - 可选扩展：积分
protocol HasIntegral: MathFunction {
    func F(_ x: Double) -> Double
}

struct QuadraticFunction: MathFunction, HasIntegral, CustomStringConvertible {
    
    var description: String {
        return "f(x) = x²"
    }
    
    func f(_ x: Double) -> Double {
        return x * x
    }
    
    func df(_ x: Double) -> Double {
        return 2 * x
    }
    
    func F(_ x: Double) -> Double {
        return x * x * x / 3
    }
}

struct ReciprocalFunction: MathFunction, HasIntegral, CustomStringConvertible {
    private let epsilon: Double = 0.01
    
    var description: String {
        return "f(x) = x-¹"
    }
    
    func f(_ x: Double) -> Double {
        if abs(x) < epsilon {
            return .infinity
        }
        
        return 1 / x
    }
    
    func df(_ x: Double) -> Double {
        if abs(x) < epsilon {
            return .infinity
        }
        
        return -1 / (x * x)
    }
    
    func F(_ x: Double) -> Double {
        if abs(x) < epsilon {
            return .infinity
        }
        return log(abs(x))
    }
}


struct LinearFunction: MathFunction, HasIntegral, CustomStringConvertible {
    // ax + b
    // default: x, linear
    // a = 2, b = 0: ax, scaled linear
    // a = 1, b = 2: x + b, linear with offset
    let a: Double
    let b: Double
    
    var description: String {
        return "f(x) = \(a)x + \(b)"
    }
    
    init(coefficient: Double = 1, offset: Double = 0) {
        self.a = coefficient
        self.b = offset
    }
    
    func f(_ x: Double) -> Double {
        return a * x + b
    }
    
    func df(_ x: Double) -> Double {
        return a
    }
    
    func F(_ x: Double) -> Double {
        return 0.5 * a * x * x + b * x
    }
}

struct ConstantFunction: MathFunction, HasIntegral, CustomStringConvertible {
    let a: Double
    
    var description: String {
        return "f(x) = \(a)"
    }
    
    init(a: Double = 2) {
        self.a = a
    }
    
    func f(_ x: Double) -> Double {
        return a
    }
    
    func df(_ x: Double) -> Double {
        return 0
    }
    
    func F(_ x: Double) -> Double {
        return a * x
    }
}


struct LogNatural: MathFunction, HasIntegral, CustomStringConvertible {
    private let epsilon: Double = 0.01
    
    var description: String {
        return "f(x) = ln(x)"
    }
    
    func f(_ x: Double) -> Double {
        if x < epsilon {
            return .infinity
        }
        return log(x)
    }
    
    func df(_ x: Double) -> Double {
        if x < epsilon {
            return .infinity
        }
        return 1 / x
    }
    
    func F(_ x: Double) -> Double {
        if x < epsilon {
            return .infinity
        }
        return x * log(x) - x
    }
}

struct LogBase10Function: MathFunction, HasIntegral, CustomStringConvertible {
    private let epsilon: Double = 0.01

    var description: String {
        return "f(x) = log₁₀(x)"
    }
    
    func f(_ x: Double) -> Double {
        if x < epsilon {
            return .infinity
        }
        return log10(x)
    }
    
    func df(_ x: Double) -> Double {
        if x < epsilon {
            return .infinity
        }
        // 1/ln(10) ≈ 0.4343
        return 0.4343 / x
    }
    
    func F(_ x: Double) -> Double {
        if x < epsilon {
            return .infinity
        }
        return 0.4343 * x * (log(x) - 1)
    }
}

struct ExponentBaseB: MathFunction, HasIntegral, CustomStringConvertible {
    // base > 0 and base != 1
    let base: Double
    
    var description: String {
        return "f(x) = \(base)ˣ"
    }
    
    init(base: Double = 2) {
        precondition(base > 0 && base != 1, "底数 base 必须大于 0 且不能等于 1")
        self.base = base
    }
    
    func f(_ x: Double) -> Double {
        return pow(base, x)
    }
    
    func df(_ x: Double) -> Double {
        return pow(base, x) * log(base)
    }
    
    func F(_ x: Double) -> Double {
        return pow(base, x) / log(base)
    }
}

struct ExponentNatural: MathFunction, HasIntegral, CustomStringConvertible {
    
    var description: String {
        return "f(x) = eˣ"
    }
    
    func f(_ x: Double) -> Double {
        return exp(x)
    }
    
    func df(_ x: Double) -> Double {
        return exp(x)
    }
    
    func F(_ x: Double) -> Double {
        return exp(x)
    }
}

struct SineFunction: MathFunction, HasIntegral, CustomStringConvertible {
    
    var description: String {
        return "f(x) = sin(x)"
    }
    
    func f(_ x: Double) -> Double {
        return sin(x)
    }
    
    func df(_ x: Double) -> Double {
        return cos(x)
    }
    
    func F(_ x: Double) -> Double {
        return -cos(x)
    }
}

struct CosineFunction: MathFunction, HasIntegral, CustomStringConvertible {
    
    var description: String {
        return "f(x) = cos(x)"
    }
    
    func f(_ x: Double) -> Double {
        return cos(x)
    }
    
    func df(_ x: Double) -> Double {
        return -sin(x)
    }
    
    func F(_ x: Double) -> Double {
        return sin(x)
    }
}

struct TangentFunction: MathFunction, HasIntegral, CustomStringConvertible {
    
    private let epsilon: Double = 0.01
    
    var description: String {
        return "f(x) = tan(x)"
    }
    
    func f(_ x: Double) -> Double {
        let periodX = mapToTangentPeriod(x)
        if isCloseToAsymptote(periodX) {
            return .infinity
        }
        return tan(x)
    }
    
    private func mapToTangentPeriod(_ x: Double) -> Double {
        return (x + .pi / 2).truncatingRemainder(dividingBy: .pi) - .pi / 2
    }
    
    private func isCloseToAsymptote(_ x: Double) -> Bool {
        return abs(abs(x) - Double.pi/2) < epsilon
    }
    
    func df(_ x: Double) -> Double {
        let t = cos(x)
        // Near ± 1/2 pi
        if abs(t) < epsilon {
            return .infinity
        }
        return 1 / (t * t)
    }
    
    func F(_ x: Double) -> Double {
        let t = cos(x)
        if abs(t) < epsilon {
            return .infinity
        }
        
        return -log(abs(t))
    }
}
