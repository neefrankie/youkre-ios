//
//  FunctionDefinition.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/18.
//
import SwiftUI

enum FunctionCategory: String {
    case linear
    case polynomial
    case exponential
    case logarithmic
    case trigonometric
    case hyperbolic
    case rational
    case constant
    case composite
    case piecewise
}

struct FunctionDefinition: Identifiable, Equatable {
    let id: String
    let slug: String
    let name: String
    let category: FunctionCategory
    
    let title: String // Uncode version the function
    let latex: String // e.g., "f(x) = x^2"
    let derivativeLatex: String // e.g., "f'(x) = 2x"
    let integralLatex: String // // e.g., "\\int x^2 dx = \\frac{1}{3}x^3"
    
    let function: MathFunction?
    let bounds: (Double, Double)
    let image: String?
    
    
    init(
        id: String? = nil,
        slug: String,
        name: String,
        category: FunctionCategory,
        title: String,
        latex: String,
        derivativeLatex: String,
        integralLatex: String,
        function: MathFunction?,
        bounds: (Double, Double) = (-5, 5),
        image: String? = nil,
    ) {
        self.id = id ?? FunctionDefinition.slugify(slug)
        self.slug = slug
        self.name = name
        self.category = category
        self.title = title
        self.latex = latex
        self.derivativeLatex = derivativeLatex
        self.integralLatex = integralLatex
        self.bounds = bounds
        self.function = function
        self.image = image
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
}
