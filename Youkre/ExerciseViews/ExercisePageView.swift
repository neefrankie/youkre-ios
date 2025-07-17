//
//  ExercisePageView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/16.
//

import SwiftUI

struct ExercisePageView: View {
    let exercise: Exercise
    @Binding var state: ExerciseState
    
    var body: some View {
        NavigationStack {
            Group {
                switch exercise.type {
                case .fillInBlank:
                    FillInBlankView(
                        currentExercise: exercise,
                        currentState: $state
                    )
                case .multipleChoice:
                    MultipleChoiceView(
                        exercise: exercise,
                        currentState: $state
                    )
                }
            }
        }
    }
}

#Preview {
//    ExercisePageView()
}
