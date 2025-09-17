//
//  ExerciseCardView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/10.
//

import SwiftUI

struct ExerciseDetailView: View {
    let level: ExerciseLevel
    let levelProgress: LevelProgress
    let exercise: Exercise
    let isLast: Bool
    var onAnswer: (ExerciseProgress) -> Void
    @Binding var showSummary: Bool
    
    @State private var viewModel = ExerciseViewModel()
    
    @Environment(\.modelContext) var modelContext
    
    private var finished: Bool {
        isLast && viewModel.selectedIndex != nil
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading exercise progress")
            } else if let currentProgress = viewModel.exerciseProgress {
                detailView(progress: currentProgress)
            } else if let error = viewModel.error {
                Text(error)
            }
        }
        .task {
            await viewModel.loadData(
                exercise: exercise,
                levelProgress: levelProgress,
                context: modelContext
            )
        }
    }
    
    @ViewBuilder
    private func detailView(progress: ExerciseProgress) -> some View {
        VStack {
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
            
            if self.finished {
                Button(action: {
                    showSummary = true
                }) {
                    Label("完成", systemImage: "")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(CapsuleButtonStyle())
                .padding()
                .padding(.bottom, 16)
            }
        }
    }
    
    private func onCheckAnswer(selected: Int) {
        let newProgress = viewModel.checkAnswer(
            selected: selected,
            exercise: self.exercise
        )
        onAnswer(newProgress)
        
        Task {
            await viewModel.updateProgress(
                progress: newProgress,
                context: modelContext
            )
        }
        
    }
}


#Preview {
    @Previewable @State var showSummary = false
    @Previewable @State var progress = ExerciseProgress.new(exerciseID: ExampleData.cmeLevels[0].exercises[0].id)
    @Previewable @StateObject var settings = ThemeManager.shared
    let level = ExampleData.cmeLevels[0]
    
    NavigationStack {
        ExerciseDetailView(
            level: level,
            levelProgress: LevelProgress.new(
                levelID: level.id,
                exerciseCount: level.exercises.count
            ),
            exercise: level.exercises[0],
            isLast: true,
            onAnswer: { anws in
                print(anws)
            },
            showSummary: $showSummary,
        )
        .navigationDestination(for: ChapterLink.self) { param in
            ChapterView(params: param)
        }
    }
    .environmentObject(settings)
    .preferredColorScheme(settings.preferredColorScheme)
}
