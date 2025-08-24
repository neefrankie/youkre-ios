//
//  DeailyExerciseDetailView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/22.
//

import SwiftUI

struct DailyExerciseDetailView: View {
    let param: DailyExerciseParam
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DailyExerciseDetailView(
        param: DailyExerciseParam(
            exercise: ExampleData.cmeLevel1Ex[0],
            level: ExampleData.cmeLevels[0]
        )
    )
}
