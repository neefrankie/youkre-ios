//
//  FunctionDefinition.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/18.
//
import SwiftUI

struct FunctionDefinition: Identifiable, Equatable {
    let id: String
    let title: String
    
    let f: (Double) -> Double
    let df: (Double) -> Double
    let a: Double
    let b: Double
    
    let latex: String // e.g., "f(x) = x^2"
    let derivativeLatex: String // e.g., "f'(x) = 2x"
    let integralLatex: String // // e.g., "\\int x^2 dx = \\frac{1}{3}x^3"
    
    init(
        id: String? = nil,
        f: @escaping (Double) -> Double,
        df: @escaping (Double) -> Double,
        a: Double,
        b: Double,
        title: String,
        latex: String,
        derivativeLatex: String,
        integralLatex: String,
    ) {
        self.id = id ?? FunctionDefinition.slugify(title)
        self.f = f
        self.df = df
        self.a = a
        self.b = b
        self.title = title
        self.latex = latex
        self.derivativeLatex = derivativeLatex
        self.integralLatex = integralLatex
    }
    
    private static func slugify(_ text: String) -> String {
        text
            .lowercased()
            .replacingOccurrences(
                of: "[^a-z0-9]",
                with: "-",
                options: .regularExpression,
            )
            .trimmingCharacters(in: CharacterSet(charactersIn: "-"))
    }
    
    static func == (lhs: FunctionDefinition, rhs: FunctionDefinition) -> Bool {
        return lhs.id == rhs.id
    }
    
    static let example = FunctionDefinition(
        f: {$0 * $0 },
        df: { 2 * $0 },
        a: -5,
        b: 5,
        title: "y = x²",
        latex: "y = x^2",
        derivativeLatex: "\\frac{dy}{dx} = 2x",
        integralLatex: "\\int y\\,dx = \\frac{1}{3}x^3 + C"
    )
    
    static let sine = FunctionDefinition(
        f: sin,
        df: cos,
        a: -2 * .pi,
        b: 2 * .pi,
        title: "y = sin(x)",
        latex: "y = \\sin(x)",
        derivativeLatex: "\\frac{dy}{dx} = \\cos(x)",
        integralLatex: "\\int y\\,dx = -\\cos(x) + C",
    )
    
    static let exponent = FunctionDefinition(
        f: exp,
        df: exp,
        a: -2,
        b: 2,
        title: "y = eˣ",
        latex: "y = \\epsilon^x",
        derivativeLatex: "\\frac{dy}{dx} = \\epsilon^x",
        integralLatex: "\\int y\\, dx = \\epsilon^x + C",
    )
}
