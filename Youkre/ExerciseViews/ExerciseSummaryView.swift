//
//  ExerciseSummaryView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/12.
//

import SwiftUI

struct ExerciseSummaryView: View {
    @ObservedObject var session: ExerciseSessionModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            Text("总结")
                .font(.largeTitle.bold())
            
            Text("答对 \(session.score) / \(session.exercises.count)")
            
            ScrollView {
                ForEach(session.exercises) { exercise in
                    let exState = session.session.state(for: exercise.id)
                    
                    ExerciseResultRow(
                        exercise: exercise,
                        state: exState
                    )
                    
                }
            }
            
            HStack {
                Button("再试错题") {
                    session.retryIncorrectOnly()
                }
                Button("全部重来") {
                    session.reset()
                }
                Spacer()
                Button("关闭") {
                    dismiss()
                }
            }
            .padding(.top)
        }
        .padding()
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    @Previewable @StateObject var session = ExerciseSessionModel(allExercises: sampleExercises)
    
    ExerciseSummaryView(session: session)
}
