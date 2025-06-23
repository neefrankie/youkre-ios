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
    @Environment(\.horizontalSizeClass) private var hSizeClass
    
    init(definition: FunctionDefinition, isActive: Bool) {
        self.definition = definition
        self.isActive = isActive
        
        _model = StateObject(
            wrappedValue: FunctionModel(
                bounds: definition.bounds,
            )
        )
    }
    
    let scale: CGFloat = 20

    var timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()

    var body: some View {
        // Views under GemometryReader is not vertically or horizontally centered.
        Group {
            if hSizeClass == .regular {
                HStack(alignment: .center, spacing: 24) {
                    graphSection()
                    // Ensure enqual height
                    .frame(maxHeight: .infinity)
                    
                    VStack {
                        functionTitle
                        
                        extraInfoSection
                        
                    }
                    // Ensure equal height
                    .frame(maxHeight: .infinity)
                    .modifier(PaddedCardStyle())
                }
                // Ensure sub-views equal height
                .fixedSize(horizontal: false, vertical: true)
                // Ensure vertically centered.
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                )
                .padding()
                
            } else {
                GeometryReader { proxy in
                    let size = min(proxy.size.width, proxy.size.height)
                    ScrollView {
                        VStack {
                            Group {
                                functionTitle
                                
                                graphSection(maxWidth: size)
                                
                                extraInfoSection
                                    .modifier(PaddedCardStyle())
                            }
                            .frame(maxWidth: 500)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
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
    
    var functionTitle: some View {
        VStack {
            Text("函数的导数和积分")
                .font(.title)
            MathView(
                equation: definition.latex,
                fontSize: 40
            )
            .fixedSize()
        }
        .padding()
    }
    
    func graphSection(maxWidth: CGFloat? = nil) -> some View {
        VStack {
            if let function = definition.function {
                FunctionGraph(
                    f: function.f,
                    df: function.df,
                    currentX: model.currentX,
                    scale: scale,
                    showTangent: true,
                    showIntegral: true,
                    xRange: model.bounds
                )
                .modifier(PaddedCardStyle())
                
                controlSection
            } else if let image = definition.image {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .modifier(PaddedCardStyle())
            }
        }
    }
    
    var controlSection: some View {
        PlaybackControlView(
            model: model
        )
        .modifier(PaddedCardStyle())
    }
    
    @ViewBuilder
    var extraInfoSection: some View {
        StandardFormView(
            derivative: definition.derivativeLatex,
            integral: definition.integralLatex,
        )
    }
}

#Preview {
    AnimatedIntegralView(
        definition: FunctionDefinition.standardForm[6],
        isActive: true,
    )
    .padding()
    .background(AppColors.background)
}



