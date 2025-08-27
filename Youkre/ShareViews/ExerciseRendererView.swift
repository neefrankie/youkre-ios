//
//  ExerciseShareView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/20.
//

import SwiftUI

struct ExerciseRendererView: View {
    let exercise: Exercise
    var body: some View {
        VStack {
            HStack {
                Image(.launchScreen)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .cornerRadius(4)
                
                Text("优克数学")
                    
            }
            
            ScrollView {
                VStack {
                    
                    PromptView(blocks: exercise.prompts)
                        .padding(.top, 32)
                    
                    VStack(spacing: 8) {
                        ForEach(exercise.multipleChoice.choices.indices, id: \.self) { i in
                            let choice = exercise.multipleChoice.choices[i]
                            
                            HStack {
                                if exercise.multipleChoice.isLatex {
                                    MathView(
                                        latex: choice,
                                        labelMode: .text,
                                        textAlignment: .left,
                                    )
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                } else {
                                    Text(choice)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            .modifier(PaddedCardStyle())
                        }
                        
                    }
                }
                .padding()
            }
        }
        .overlay(alignment: .bottom) {
            HStack {
                Image(.appStoreBadge)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: .infinity)
                
                Image(.appStoreQr)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: .infinity)
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .padding(.top, 32)
            .background(
                AppColors.background
            )
        }
        .frame(maxWidth: .infinity)
        .background(AppColors.background)
    }
}

#Preview {
    ExerciseRendererView(
        exercise: ExampleData.stats[0].exercises[0]
    )
    
}
