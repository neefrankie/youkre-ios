//
//  DailyExerciseCardView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/22.
//

import SwiftUI

struct DailyExerciseCardView: View {
    let exercise: Exercise
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            MarkdownView(markdown: exercise.prompts)
        }
        .modifier(PaddedCardStyle())
        
    }
}

#Preview {
    DailyExerciseCardView(
        exercise: ExampleData.cmeLevel1Ex[0]
    )
}
