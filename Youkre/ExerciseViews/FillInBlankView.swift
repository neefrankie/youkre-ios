//
//  FillInBlankExerciseView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/10.
//

import SwiftUI

struct FillInBlankView: View {
    let currentExercise: Exercise
    @Binding var currentState: ExerciseState
    @State private var userInput = ""
    
//    @ObservedObject var session: ExerciseSessionModel
    
    var body: some View {
        ExerciseContainerView(
            exercise: currentExercise,
            inputView: {
                VStack(alignment: .leading, spacing: 8) {
                    validatedTextField(currentState: currentState)
                    
                    feedbackSection(exerciseState: currentState)
                }
            }
        )
        .onAppear {
            // Sync data on appear.
            if case .text(let answered) = currentState.answer {
                self.userInput = answered
            }
        }
        
    }
    
    private func validatedTextField(currentState: ExerciseState) -> some View {
        
        ZStack(alignment: .trailing) {
            ZStack(alignment: .leading) {
                Image(systemName: "pencil")
                TextField("请输入答案", text: $userInput, onCommit: checkAnswer)
                    .keyboardType(.decimalPad)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 24)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .padding(.top, 35)
                            .foregroundColor(self.foregroundColor(exerciseState: currentState)),
                        alignment: .bottom
                    )
                    .disabled(currentState.isAnswered && !currentState.skipped)
            }
            
            if currentState.isAnswered {
                Image(systemName: currentState.isCorrect ? "checkmark" : "xmark")
                    .foregroundColor(currentState.isCorrect ? .green : .red)
                    .transition(.opacity)
            }
        }
    }
    
    private func checkAnswer() {
        
        let answer = userInput
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        if answer.isEmpty {
            return
        }
        
        let correctAnswer = currentExercise.fillInAnswer ?? ""
        
        let isCorrect = answer == correctAnswer.lowercased()
        currentState = ExerciseState.answered(
            correct: isCorrect,
            answer: .text(answer)
        )
    }
    
    private func feedbackSection(exerciseState: ExerciseState) -> some View {
        Group {
            if !exerciseState.isAnswered {
                HStack(alignment: .top) {
                    Spacer()
                    
                    Button("提交") {
                        checkAnswer()
                    }
                    .buttonStyle(ProminentButtonStyle(backgroundColor: .teal))
                    
                    Spacer()
                }
                .frame(minHeight: 44)
                
            } else {
                HStack(alignment: .top) {
                    Spacer()
                    if exerciseState.isCorrect {
                        Text("回答正确！太棒了！")
                            .foregroundColor(.green)
                    } else {
                        Text("正确答案：\(currentExercise.fillInAnswer ?? "")")
                    }
                    Spacer()
                }
                .frame(minHeight: 44)
            }
        }
    }
    
    func foregroundColor(exerciseState: ExerciseState) -> Color {
        if exerciseState.isAnswered {
            switch exerciseState.isCorrect {
            case true:
                return .green
            case false:
                return .red
            }
        } else {
            return .gray
        }
    }
}

#Preview {
    
    @Previewable @State var exState = ExerciseState()
    @Previewable @StateObject var settings = ThemeManager.shared
    
    FillInBlankView(
        currentExercise: ExerciseData.algebra[26],
        currentState: $exState,
    )
    .environmentObject(settings)
    .preferredColorScheme(settings.preferredColorScheme)
}
