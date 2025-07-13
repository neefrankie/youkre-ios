//
//  ExerciseCardView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/10.
//

import SwiftUI

struct MultipleChoiceView: View {
    @ObservedObject var session: ExerciseSessionModel

    var body: some View {
        let exercise = session.currentExercise
        let currentState = session.currentState
        let multipleChoice = exercise?.multipleChoice ?? MultipleChoice(choices: [], correctIndex: -1)
        
        if let exercise {
            ExerciseContainerView(
                exercise: exercise,
                inputView: {
                    VStack {
                        ForEach(multipleChoice.choices.indices, id: \.self) { i in
                            Button(action: {
                                self.checkAnswer(selectedIndex: i, multipleChoice: multipleChoice)
                            }) {
                                HStack {
                                    Text(multipleChoice.choices[i])
                                        .fixedSize(horizontal: true, vertical: false)
                                        .padding(.trailing, 20)
                                    Spacer()
                                    trailingImage(
                                        for: i,
                                        currentState: currentState,
                                        correctIndex: multipleChoice.correctIndex,
                                    )
                                        .frame(width: 20, height: 20)
                                }
                                .padding()
                                .background(
                                    buttonColor(
                                        for: i,
                                        currentState: currentState,
                                        correctIndex: multipleChoice.correctIndex
                                    )
                                )
                                .cornerRadius(8)
                            }
                            .disabled(currentState.isAnswered)
                        }
                    }
                }
                
                
            )
        }
    }
    
    private func checkAnswer(selectedIndex: Int, multipleChoice: MultipleChoice) {
        guard !session.currentState.isAnswered else { return }
        
        let correctAnswer = multipleChoice.correctIndex
        
        session.submitAnswer(
            correct: selectedIndex == correctAnswer,
            answer: .choice(index: selectedIndex)
        )
    }
    
    private func trailingImage(for index: Int, currentState: ExerciseState, correctIndex: Int) -> some View {
        if case .choice(let selected) = currentState.answer {
            if index == selected {
                // Index is selected and it is the correct index.
                if index == correctIndex {
                    return Image(systemName: "checkmark")
                        .foregroundColor(.green)
                } else {
                    return Image(systemName: "xmark")
                        .foregroundColor(.red)
                }
            }
        }
        
        return Image(systemName: "")
            .foregroundColor(.clear)
    }
    
    private func buttonColor(for index: Int, currentState: ExerciseState, correctIndex: Int) -> Color {
        if index == correctIndex {
            return .green.opacity(0.3)
        } else if case .choice(let selected) = currentState.answer, index == selected {
            return .red.opacity(0.3)
        } else {
            return .gray.opacity(0.1)
        }
    }
}


#Preview {
    @Previewable @StateObject var session = ExerciseSessionModel(allExercises: sampleExercises)
    
    MultipleChoiceView(session: session)
}
