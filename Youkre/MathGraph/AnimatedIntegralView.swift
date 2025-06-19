//
//  AnimatedIntegralView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/18.
//

import SwiftUI

struct AnimatedIntegralView: View {
    let definition: FunctionDefinition
    let isActive: Bool
    
    @StateObject private var model: FunctionModel
    @Environment(\.colorScheme) private var colorScheme
    
    init(definition: FunctionDefinition, isActive: Bool) {
        self.definition = definition
        self.isActive = isActive
        
        _model = StateObject(
            wrappedValue: FunctionModel(
                f: definition.f,
                df: definition.df,
                a: definition.a,
                b: definition.b,
            )
        )
    }
    
    let scale: CGFloat = 20

    var timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            
            VStack {
                MathView(
                    equation: definition.latex
                )
                
                FunctionGraph(
                    f: model.f,
                    df: model.df,
                    currentX: model.currentX,
                    scale: scale,
                    showTangent: true,
                    showIntegral: true,
                    xRange: (model.a, model.b)
                )
                .modifier(CardStyle())
                .frame(width: size, height: size)
                .aspectRatio(1, contentMode: .fit)
                
                PlaybackControlView(
                    model: model
                )
                .modifier(CardStyle())
                
                VStack(spacing: 12) {
                    LabeledFormulaView(
                        title: "导数",
                        latex: definition.derivativeLatex,
                    )
                    Divider()
                    
                    LabeledFormulaView(
                        title: "积分",
                        latex: definition.integralLatex,
                    )
                }
                .modifier(CardStyle())
            }
        }
        
        .onReceive(timer) { _ in
            if isActive {
                model.tick()
            }
        }
        .onChange(of: isActive) { _, newValue in
            model.setPlaying(newValue)
        }
        .onAppear {
            model.setPlaying(isActive)
        }
        
    }
}

#Preview {
    AnimatedIntegralView(
        definition: .example,
        isActive: true,
    )
    .padding()
    .background(AppColors.background)
}
