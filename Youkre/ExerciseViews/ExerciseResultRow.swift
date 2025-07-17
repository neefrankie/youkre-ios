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
        VStack(alignment: .leading, spacing: 16) {
            if !exercise.promptParts.isEmpty {
                PromptView(blocks: exercise.promptParts)
            }
            
            switch state.answer {
            case .text(let value):
                answerView(answered: value, correct: exercise.fillInAnswer ?? "")
                
            case .choice(let index):
                if let multiple = exercise.multipleChoice {
                    let answered = multiple.choices[index]
                    let correct = multiple.correctAnswer
                    
                    answerView(answered: answered, correct: correct, isLatex: multiple.isLatex)
                }
            case .choices(let indices):
                let answers = indices.compactMap { exercise.multipleChoice?.choices[safe: $0] }
                Text("你的选择：\(answers.joined(separator: ", "))")
                    .foregroundStyle(.secondary)
                
            case .none:
                if state.skipped {
                    skippedView()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .border(.gray)
        
    }
    
    private func skippedView() -> some View {
        HStack {
            icon
            Text("你跳过了此题")
                .foregroundStyle(.orange)
        }
    }
    
    private func answerView(answered: String, correct: String, isLatex: Bool = false) -> some View {
        VStack {
            HStack {
                icon
                Text("你的答案:")
                Spacer()
                if isLatex {
                    MathView(
                        latex: answered,
                        fontSize: 20
                    )
                    .fixedSize()
                } else {
                    Text(answered)
                }
                
            }
            .foregroundStyle(.secondary)
            
            if !state.isCorrect {
                HStack {
                    Image(systemName: "checkmark")
                    Text("正确答案:")
                    Spacer()
                    if isLatex {
                        MathView(
                            latex: correct,
                            fontSize: 20
                        )
                        .fixedSize()
                    } else {
                        Text(correct)
                    }
                }
                .foregroundStyle(.green)
            }
        }
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
}

#Preview {
    ExerciseResultRow(
        exercise: ExerciseData.calculus[ExerciseData.calculus.count-1],
        state: ExerciseState(
            isAnswered: true,
            isCorrect: false,
            skipped: false,
            answer: .choice(index: 1)
        )
    )
    
    ExerciseResultRow(
        exercise: ExerciseData.algebra[0],
        state: ExerciseState(
            isAnswered: true,
            isCorrect: false,
            skipped: false,
            answer: .text("3")
        )
    )
    
    ExerciseResultRow(
        exercise: ExerciseData.algebra[0],
        state: ExerciseState(
            isAnswered: false,
            isCorrect: false,
            skipped: true,
            answer: .none
        )
    )
}
