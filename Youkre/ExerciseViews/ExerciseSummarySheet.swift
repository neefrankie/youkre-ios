//
//  ExerciseSummaryView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/12.
//

import SwiftUI

struct ExerciseSummarySheet: View {
    @ObservedObject var session: ExerciseSessionModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            Text("总结")
                .font(.largeTitle.bold())
            
            Text("答对 \(session.score) / \(session.exercises.count)")
            
            ScrollView(showsIndicators: false) {
                ForEach(session.exercises) { exercise in
                    let exState = session.session.state(for: exercise.id)
                    
                    ExerciseResultRow(
                        exercise: exercise,
                        state: exState
                    )
                    
                }
            }
            
            HStack {
                Button {
                    session.retryIncorrectOnly()
                    dismiss()
                } label: {
                    Label("重试错题", systemImage: "arrow.trianglehead.clockwise")
                }
                .buttonStyle(ProminentButtonStyle(backgroundColor: .secondary))
                
                Button {
                    session.restart()
                    dismiss()
                } label: {
                    Label("再做一遍", systemImage: "repeat")
                }
                .buttonStyle(ProminentButtonStyle())
            }
            .padding(.top)
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("关闭") {
                    dismiss()
                }
            }
        }
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    @Previewable @StateObject var session = ExerciseSessionModel()
    
    NavigationStack {
        ExerciseSummarySheet(session: session)
    }
    
}
