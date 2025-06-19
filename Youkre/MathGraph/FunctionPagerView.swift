//
//  FunctionPagerView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/18.
//

import SwiftUI

struct FunctionPagerView: View {
    @State private var currentPage: Int = 0
    
    let definitions: [FunctionDefinition] = [
        FunctionDefinition.example,
        FunctionDefinition.sine,
        FunctionDefinition.exponent,
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(definitions.indices, id: \.self) { index in
                            let def = definitions[index]
                            Button(action: {
                                withAnimation {
                                    currentPage = index
                                    proxy.scrollTo(index, anchor: .center)
                                }
                            }) {
                                Text(def.title)
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 6)
                            }
                            .foregroundColor(currentPage == index ? .primary : .gray)
                        }
                    }
                    .padding(.horizontal)
                }
                .onChange(of: currentPage) { _, newIndex in
                    withAnimation {
                        proxy.scrollTo(newIndex, anchor: .center)
                    }
                }
            }
            
            
            Divider()
            
            TabView(selection: $currentPage) {
                ForEach(
                    definitions.indices,
                    id: \.self
                ) { index in
                    AnimatedIntegralView(
                        definition: definitions[index],
                        isActive: index == currentPage
                    )
                    .padding()
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        
    }
}

#Preview {
    FunctionPagerView()
        .background(AppColors.background)
}
