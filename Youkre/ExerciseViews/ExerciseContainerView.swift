//
//  ExerciseContainerView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/10.
//

import SwiftUI

struct ExerciseContainerView<InputView: View>: View {
    let exercise: ExerciseV2
    let inputView: () -> InputView
    
    @State private var showExplanation = false
    
    var body: some View {
        VStack(spacing: 16) {
            
            Spacer()
            
            inputView()
            
            Spacer()
            
//            HStack {
//                
////                NavigationLink(value: exercise.learnMore) {
////                    Label("相关知识", systemImage: "book")
////                }
////                .buttonStyle(CapsuleBorderButtonStyle())
//                
//                Spacer()
//                
//                if exercise.explanation != nil {
//                    Button {
//                        showExplanation = true
//                    } label: {
//                        Label("查看讲解", systemImage: "questionmark")
//                    }
//                    .buttonStyle(CapsuleBorderButtonStyle())
//                }
//            }
//            .padding(.bottom, 16)
            
        }
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button{
                    
                } label: {
                    Label("理论", systemImage: "book")
                }
                Spacer()
                Button{
                    
                } label: {
                    Label("分享", systemImage: "square.and.arrow.up")
                }
                Spacer()
                Button {
                    showExplanation = true
                } label: {
                    Label("解析", systemImage: "questionmark")
                        
                }
            }
        }
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

#Preview {
    @Previewable @StateObject var themeManager = ThemeManager.shared
    
    NavigationStack {
        ExerciseContainerView(
            exercise: LevelData.cme[0].exercises[0],
            inputView: {
                Text("Enter you answer")
            },
        )
    }
    .environmentObject(themeManager)
    .preferredColorScheme(themeManager.preferredColorScheme)
}
