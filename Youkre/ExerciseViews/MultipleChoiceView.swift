//
//  ExerciseCardView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/10.
//

import SwiftUI

struct MultipleChoiceView: View {
    let exercise: Exercise
    @Binding var currentState: ExerciseState
    @State private var selectedIndex: Int? = nil

    var body: some View {
        let multipleChoice = exercise.multipleChoice ?? MultipleChoice(choices: [], correctIndex: -1)
        
        
        ExerciseContainerView(
            exercise: exercise,
            inputView: {
                VStack {
                    ForEach(multipleChoice.choices.indices, id: \.self) { i in
                        Button(action: {
                            selectedIndex = i
                            checkAnswer(
                                correctIndex: multipleChoice.correctIndex
                            )
                        }) {
                            HStack {
                                if multipleChoice.isLatex {
                                    MathView(
                                        latex: multipleChoice.choices[i],
                                        fontSize: 20,
                                        labelMode: .text,
                                        textAlignment: .left,
                                        textColor: .primary
                                    )
                                    .fixedSize()
                                } else {
                                    Text(multipleChoice.choices[i])
                                        .fixedSize(horizontal: true, vertical: false)
                                        .padding(.trailing, 20)
                                        .foregroundColor(.primary)
                                }
                                
                                Spacer()
                                trailingImage(
                                    for: i,
                                    correctIndex: multipleChoice.correctIndex,
                                )
                                .frame(width: 20, height: 20)
                            }
                            .padding()
                            .background(
                                buttonColor(
                                    for: i,
                                    correctIndex: multipleChoice.correctIndex
                                )
                                .animation(
                                    .easeInOut(duration: 0.4),
                                    value: selectedIndex,
                                )
                            )
                            .cornerRadius(8)
                        }
                        .disabled(currentState.isAnswered)
                    }
                }
            }
            
            
        )
        .onAppear {
            // Sync data on appear.
            if case .choice(let selected) = currentState.answer {
                self.selectedIndex = selected
            }
        }
    }
    
    private func checkAnswer(correctIndex: Int) {
        // Only allow answer once
        guard !currentState.isAnswered else { return }
        
        guard let selected = selectedIndex else { return }
        
        print(selected)
        currentState = ExerciseState.answered(
            correct: selected == correctIndex,
            answer: .choice(index: selected)
        )
    }
    
    private func trailingImage(for index: Int, correctIndex: Int) -> some View {
        if let selected = selectedIndex {
            // Only add mark to selected one.
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
    
    private func buttonColor(for index: Int, correctIndex: Int) -> Color {
        // If ther's a choice, it indicates the answer is selected and exercise is not skipped.
        if let selected = selectedIndex {
            // Correct answer always show green background after user make choice.
            if index == correctIndex {
                return .green.opacity(0.3)
            } else if index == selected {
                // index is not the correntIndex but is selected, so it's not correct.
                return .red.opacity(0.3)
            }
        }
        
        return .gray.opacity(0.1)
    }
}


#Preview {
    @Previewable @State var exState = ExerciseState()
    @Previewable @StateObject var settings = ThemeManager.shared
    
    MultipleChoiceView(
        exercise: sampleExercises[1],
        currentState: $exState
    )
    .environmentObject(settings)
    .preferredColorScheme(settings.preferredColorScheme)
}
