//
//  IconStore.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/8.
//

import SwiftUI

// To mix different view into a map, only solution is AnyView.
// To use [String: () -> some View], you must ensure every instance
// is created from the same struct.
struct IconStore {
    static let symbolViewMap: [String: () -> AnyView] = [
        // Math symbol rendered with LaTeX.
        // GROUP: function
        "composition": {
            AnyView(
                IconBoxView(background: .purple) {
                    LatexIconView(
                        latex: "f\\circ g",
                        fontSize: 18
                    )
                }
            )
        },
        "power": {
            AnyView(
                IconBoxView(background: .purple) {
                    LatexIconView(
                        latex: "x^n"
                    )
                }
            )
        },
        
        
        // GROUP: integation
        "definite-integral": {
            AnyView(
                IconBoxView(background: .indigo) {
                    LatexIconView(
                        latex: "\\int_a^b",
                    )
                }
            )
        },
        "integral": {
            AnyView(
                IconBoxView(background: .indigo) {
                    LatexIconView(latex: "\\int")
                }
            )
        },
        "product": {
            AnyView(
                IconBoxView(background: .indigo) {
                    LatexIconView(
                        latex: "\\prod"
                    )
                }
            )
        },
        "seq": {
            AnyView(
                IconBoxView(background: .pink) {
                    LatexIconView(
                        latex: "a_n"
                    )
                }
            )
        },
        "sum": {
            AnyView(
                IconBoxView(background: .orange) {
                    LatexIconView(
                        latex: "\\sum"
                    )
                }
            )
        },
        
        // GROUP: derivative
        "derivative": {
            AnyView(
                IconBoxView(background: .teal) {
                    LatexIconView(
                        latex: "\\frac{d}{dx}",
                    )
                }
            )
        },
        "dx": {
            AnyView(
                IconBoxView(background: .teal) {
                    LatexIconView(
                        latex: "dx"
                    )
                }
            )
        },
        "limit": {
            AnyView(
                IconBoxView(background: .blue) {
                    LatexIconView(
                        latex: "\\lim_{x \\to 0}",
                        fontSize: 18,
                        mode: .display
                    )
                }
            )
        },
        
        // GROUP: exponential and log
        "exponential": {
            AnyView(
                IconBoxView(background: .green) {
                    LatexIconView(
                        latex: "e^x"
                    )
                }
            )
        },
        "log": {
            AnyView(
                IconBoxView(background: .mint) {
                    LatexIconView(
                        latex: "\\ln x"
                    )
                }
            )
        },
        
        // GROUP: operators
        "fraction": {
            AnyView(
                IconBoxView(background: .orange) {
                    LatexIconView(
                        latex: "\\frac{a}{b}"
                    )
                }
            )
        },
        "paren": {
            AnyView(
                IconBoxView(background: .orange) {
                    LatexIconView(
                        latex: "()"
                    )
                }
            )
        },
        "set": {
            AnyView(
                IconBoxView(background: .gray) {
                    LatexIconView(
                        latex: "\\in, \\mathbb{R}",
                        fontSize: 18
                    )
                }
            )
        },
        "sqrt": {
            AnyView(
                IconBoxView(background: .cyan) {
                    LatexIconView(
                        latex: "\\sqrt{x}"
                    )
                }
            )
        },
        "vector": {
            AnyView(
                IconBoxView(background: .green) {
                    LatexIconView(
                        latex: "\\vec{v}"
                    )
                }
            )
        },
        
        // The following are drawn with Canvas
        "cubic-function": {
            AnyView(
                IconBoxView(background: .blue) {
                    FunctionIcon()
                }
            )
        },
        "parabola": {
            AnyView(
                IconBoxView(background: .yellow) {
                    ParabolaIcon()
                }
            )
        },
        "sequence": {
            AnyView(
                IconBoxView(background: .pink) {
                    SequenceIcon()
                }
            )
        },
        "integral-area": {
            AnyView(
                IconBoxView(background: .indigo) {
                    IntegralAreaIcon()
                }
            )
        }
    ]
}

#Preview {
    var items: [(key: String, viewCreator: () -> AnyView)] {
        return Array(IconStore.symbolViewMap.map { ($0.key, $0.value) } )
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    ScrollView {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(items, id: \.key) { item in
                item.viewCreator()
            }
        }
    }
}
