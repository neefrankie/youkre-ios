//
//  ExerciseResultRow.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/13.
//

import SwiftUI

struct ExerciseResultRow: View {
    let exercise: Exercise
    let state: ExerciseState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack {
                Text(exercise.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                if !exercise.promptParts.isEmpty {
                    promptView(parts: exercise.promptParts)
                }
            }
            
            HStack {
                icon
                
                switch state.answer {
                case .text(let value):
                    Text("你的答案：\(value)")
                        .foregroundStyle(.secondary)
                    
                case .choice(let index):
                    if let choice = exercise.multipleChoice?.choices[safe: index] {
                        Text("你的选择：\(choice)")
                            .foregroundStyle(.secondary)
                    }
                case .choices(let indices):
                    let answers = indices.compactMap { exercise.multipleChoice?.choices[safe: $0] }
                    Text("你的选择：\(answers.joined(separator: ", "))")
                        .foregroundStyle(.secondary)
                    
                case .none:
                    if state.skipped {
                        Text("你跳过了此题")
                            .foregroundStyle(.orange)
                    }
                }
            }
            
            
            if state.isAnswered && !state.isCorrect {
                HStack {
                    Image(systemName: "checkmark")
                    Text("正确答案：\(exercise.correctAnswer)")
                }
                .foregroundStyle(.green)
                
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        
        .cornerRadius(8)
        .border(.gray)
        
    }
    
    private var icon: some View {
        Group {
            if state.skipped {
                Image(systemName: "arrowshape.turn.up.left.fill").foregroundColor(.orange)
            } else if state.isCorrect {
                Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
            } else if state.isAnswered {
                Image(systemName: "xmark.circle.fill").foregroundColor(.red)
            } else {
                Image(systemName: "circle").foregroundColor(.gray)
            }
        }
        .font(.title3)
    }
    
    func promptView(parts: [PromptPart]) -> some View {
        VStack(spacing: 8) {
            ForEach(parts.indices, id: \.self) { i in
                let part = parts[i]
                switch part {
                case .text(let s):
                    Text(s)
                        
                case .latex(let ltx):
                    MathView(
                        latex: ltx,
                        fontSize: 20
                    )
                    .fixedSize()
                }
            }
        }
    }
}

#Preview {
    ExerciseResultRow(
        exercise: sampleExercises[0],
        state: ExerciseState(
            isAnswered: true,
            isCorrect: false,
            skipped: false,
            answer: .text("3")
        )
    )
}
