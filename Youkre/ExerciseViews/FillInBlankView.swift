//
//  FillInBlankExerciseView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/10.
//

import SwiftUI

struct FillInBlankView: View {
    @ObservedObject var session: ExerciseSessionModel
    @State private var userInput = ""
    
    var body: some View {
        if let exercise = session.currentExercise {
            ExerciseContainerView(
                exercise: exercise,
                inputView: {
                    VStack(alignment: .leading, spacing: 8) {
                        let currentState = session.currentState
                        
                        validatedTextField(currentState: currentState)
                        
                        feedbackSection(exerciseState: currentState)
                    }
                }
            )
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
                    .animation(.easeInOut(duration: 0.3), value: currentState.isCorrect)
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
        
        let correctAnswer = session.currentExercise?.fillInAnswer ?? ""
        
        let isCorrect = answer == correctAnswer.lowercased()
        session.submitAnswer(
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
                        Text("正确答案：\(session.currentExercise?.fillInAnswer ?? "")")
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
    @Previewable @StateObject var session = ExerciseSessionModel(allExercises: sampleExercises)
    
    FillInBlankView(session: session)
}
