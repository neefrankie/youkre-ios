//
//  ExerciseContainerView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/10.
//

import SwiftUI

struct ExerciseContainerView<InputView: View>: View {
    let exercise: Exercise
    let inputView: () -> InputView
    
    @State private var showExplanation = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                Spacer()
                
                VStack(spacing: 16) {
                    Text(exercise.title)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    LocalizedPromptView(parts: exercise.promptParts)
                    
                    inputView()
                }
                
                Spacer()
                
                HStack {
                    
                    NavigationLink(value: exercise.learnMore) {
                        Label("相关知识", systemImage: "book")
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    if exercise.explanation != nil {
                        Button {
                            showExplanation = true
                        } label: {
                            Label("查看讲解", systemImage: "questionmark")
                                .font(.headline)
                                .padding(.top, 8)
                        }
                        .foregroundColor(.teal)
                    }
                }
                .padding(.bottom, 32)
                
            }
            .padding()
            .sheet(isPresented: $showExplanation) {
                if let explanation = exercise.explanation {
                    ExplanationSheetView(explanation: explanation)
                }
            }
            .navigationDestination(
                for: ChapterLink.self,
            ) { param in
                ChapterView(params: param)
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var themeManager = ThemeManager.shared
    
    NavigationStack {
        ExerciseContainerView(
            exercise: sampleExercises[0],
            inputView: {
                Text("Enter you answer")
            },
        )
    }
    .environmentObject(themeManager)
    .preferredColorScheme(themeManager.preferredColorScheme)
}
