//
//  ExerciseShareView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/20.
//

import SwiftUI

struct ExerciseShareView: View {
    let exercise: ExerciseV2
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    Image(.launchScreen)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .cornerRadius(4)
                    
                    Text("优克数学")
                        
                }
                
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
                        .padding()
                        .background(AppColors.contentBackground)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                    }
                }
            }
            .padding()
            
            HStack {
                Image(.appStoreBadge)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                
                Image(.appStoreQr)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            }
            
        }
        .frame(maxWidth: .infinity)
        .background(AppColors.background)
    }
}

#Preview {
    ExerciseShareView(
        exercise: ExampleData.cmeLevel1Ex[0]
    )
    
}
