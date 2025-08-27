//
//  ExerciseBottomBar.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/20.
//

import SwiftUI
import Photos

struct ExerciseBottomBar: View {
    let level: ExerciseLevel
    let exercise: Exercise
    
    @State private var showExplanation = false
    
    @State private var showPreview = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            Divider()
            HStack(spacing: 32) {
                NavigationLink(value: level.learnMore) {
                    VStack(spacing: 4) {
                        Image(systemName: "book")
                        Text("了解更多")
                            .font(.caption2)
                    }
                }

                Spacer()
                
                Button(action: {
                    showPreview = true
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: "square.and.arrow.up")
                        Text("分享")
                            .font(.caption2)
                    }
                }
                
                if exercise.explanation != nil {
                    Spacer()

                    Button {
                        showExplanation = true
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: "questionmark")
                            Text("解析")
                                .font(.caption2)
                        }
                    }
                }
                
            }
            .padding()
            
        }
        .sheet(isPresented: $showExplanation) {
            if let explanation = exercise.explanation {
                ExplanationSheetView(explanation: explanation)
            }
        }
        .sheet(isPresented: $showPreview) {
            ExerciseShareView(exercise: exercise)
        }
    }
}

#Preview {
    NavigationStack {
        ExerciseBottomBar(
            level: ExampleData.cmeLevels[0],
            exercise: ExampleData.cmeLevel1Ex[0]
        )
    }
    
}
