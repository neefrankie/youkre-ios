//
//  DeailyExerciseDetailView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/22.
//

import SwiftUI

struct DailyExerciseDetailView: View {
    let level: ExerciseLevel
    let exercise: Exercise
    
    @State private var exerciseInfo: DailyExerciseInfo?
    
    @Environment(\.dismiss) private var dismiss
    
    init(param: DailyExerciseParam) {
        self.level = param.level
        self.exercise = param.exercise
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
//                PromptView(blocks: exercise.prompts)
                MarkdownView(markdown: exercise.prompts)
                
                ForEach(exercise.multipleChoice.choices.indices, id: \.self) { i in
                    Button(action: {
                        checkAnswer(selected: i)
                    }) {
                        OptionItemView(
                            choice: exercise.multipleChoice.choices[i],
                            isLatex: exercise.multipleChoice.isLatex,
                            correctIndex: exercise.multipleChoice.correctIndex,
                            optionIndex: i,
                            selectedIndex: exerciseInfo?.selectedIndex,
                        )
                    }
                }
            }
            .padding()
            .onAppear {
                self.exerciseInfo = CourseSettings.loadDailyExercise()
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                ExerciseBottomBar(
                    level: level,
                    exercise: exercise
                )
            }
        }
    }
    
    private func checkAnswer(selected: Int) {
        if exerciseInfo != nil {
            exerciseInfo?.selectedIndex = selected
        } else {
            exerciseInfo = DailyExerciseInfo.new(exerciseID: exercise.id, selected: selected)
        }
        
        guard let info = exerciseInfo else {
            return
        }
        CourseSettings.saveDailyExercise(info: info)
    }
}

#Preview {
    NavigationStack {
        DailyExerciseDetailView(
            param: DailyExerciseParam(
                exercise: ExampleData.cmeLevel1Ex[0],
                level: ExampleData.cmeLevels[0]
            )
        )
    }
}
