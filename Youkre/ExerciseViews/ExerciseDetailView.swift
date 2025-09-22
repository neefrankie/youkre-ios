//
//  ExerciseCardView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/10.
//

import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise
    let levelProgress: LevelProgress
    let exerciseProgress: ExerciseProgress? // If retrieved in LevelViewModel, avoid querying db again since SwiftData is very cumbersome in this case.
    let isLast: Bool
    var onAnswer: (ExerciseProgress) -> Void
    
    @State private var viewModel = ExerciseViewModel()
    
    @Environment(\.modelContext) var modelContext
    
    private var finished: Bool {
        isLast && viewModel.selectedIndex != nil
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if let currentProgress = viewModel.exerciseProgress {
                detailView(progress: currentProgress)
            } else if let error = viewModel.error {
                Text(error)
            }
        }
        .onAppear {
            viewModel.loadData(
                for: exercise,
                of: levelProgress,
                exerciseProgress: exerciseProgress,
            )
        }
    }
    
    @ViewBuilder
    private func detailView(progress: ExerciseProgress) -> some View {
        ScrollView {
            VStack(spacing: 16) {
                MarkdownView(markdown: exercise.prompts)
                
                ForEach(exercise.multipleChoice.choices.indices, id: \.self) { i in
                    Button(action: {
                        onCheckAnswer(selected: i)
                    }) {
                        
                        OptionItemView(
                            choice: exercise.multipleChoice.choices[i],
                            isLatex: exercise.multipleChoice.isLatex,
                            correctIndex: exercise.multipleChoice.correctIndex,
                            optionIndex: i,
                            selectedIndex: viewModel.selectedIndex,
                        )
                    }
                    .disabled(progress.isCompleted)
                }
            }
            .padding()
        }
    }
    
    private func onCheckAnswer(selected: Int) {
        let newProgress = viewModel.checkAnswer(
            selected: selected,
            exercise: self.exercise
        )
        onAnswer(newProgress)
    }
}


#Preview {
    @Previewable @State var showSummary = false
    @Previewable @State var progress = ExerciseProgress.new(exerciseID: ExampleData.cmeLevels[0].exercises[0].id)
    @Previewable @StateObject var settings = ThemeManager.shared
    let level = ExampleData.cmeLevels[0]
    
    NavigationStack {
        ExerciseDetailView(
            exercise: level.exercises[0],
            levelProgress: LevelProgress.new(
                levelID: level.id,
                exerciseCount: level.exercises.count
            ),
            exerciseProgress: nil,
            isLast: true,
            onAnswer: { anws in
                print(anws)
            },
        )
        .navigationDestination(for: ChapterLink.self) { param in
            ChapterView(params: param)
        }
    }
    .environmentObject(settings)
    .preferredColorScheme(settings.preferredColorScheme)
}
