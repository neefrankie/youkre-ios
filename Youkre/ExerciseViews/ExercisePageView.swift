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
            MultipleChoiceView(
                exercise: exercise,
                currentState: $state
            )
        }
    }
}

#Preview {
//    ExercisePageView()
}
