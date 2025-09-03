//
//  ExerciseCardView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/10.
//

import SwiftUI

struct MultipleChoiceView: View {
    let level: ExerciseLevel
    let levelProgress: LevelProgress
    let exercise: Exercise
    let isLast: Bool
    @Binding var showSummary: Bool
    var onAnswer: (ExerciseProgress) -> Void
    var onLevelComplete: () -> Void
    
    @State private var isLoading: Bool = true
    @State private var error: String? = nil
    @State private var currentProgress: ExerciseProgress? = nil
    
    // Exercise choice index selected.
    @State private var selectedIndex: Int? = nil
    @Environment(\.modelContext) var modelContext
    
    private var finished: Bool {
        isLast && selectedIndex != nil
    }

    var body: some View {
        Group {
            if self.isLoading {
                ProgressView("Loading exercise progress")
            } else if let currentProgress {
                detailView(progress: currentProgress)
            } else if let error {
                Text(error)
            }
        }
        .task {
            print("Initialize loadExerciseProgress")
            await loadExerciseProgress()
        }
    }
    
    @ViewBuilder
    private func detailView(progress: ExerciseProgress) -> some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
//                    PromptView(blocks: exercise.prompts)
                    MarkdownView(markdown: exercise.prompts)
                    
                    ForEach(exercise.multipleChoice.choices.indices, id: \.self) { i in
                        Button(action: {
                            selectedIndex = i
                            checkAnswer(
                                correctIndex: exercise.multipleChoice.correctIndex
                            )
                        }) {
                            
                            OptionItemView(
                                choice: exercise.multipleChoice.choices[i],
                                isLatex: exercise.multipleChoice.isLatex,
                                correctIndex: exercise.multipleChoice.correctIndex,
                                optionIndex: i,
                                selectedIndex: selectedIndex,
                            )
                        }
                        .disabled(progress.isCompleted)
                    }
                }
                .padding()
            }
            
            if self.finished {
                Button(action: {
                    onLevelComplete()
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
    
    private func checkAnswer(correctIndex: Int) {
        guard var progress = currentProgress else { return }
        // Only allow answer once
        guard !progress.isCompleted else { return }
        
        guard let selected = selectedIndex else { return }
        
        progress.answered(
            correct: selected == correctIndex,
            selectedIndex: selected,
        )
        
        onAnswer(progress)
        self.currentProgress = progress
        
        // Save exercise progress upon clicking a choice.
        Task {
            await updateExerciseProgress(progress: progress)
        }
    }
    
    @MainActor
    func loadExerciseProgress() async {
        print("loadExerciseProgress")
        isLoading = true
        do {
            let exerciseProgress = try await SessionDataSource.shared.loadOrCreateExerciseProgress(
                levelProgress: self.levelProgress,
                exercise: self.exercise,
                context: modelContext
            )
            self.currentProgress = exerciseProgress
            self.selectedIndex = exerciseProgress.selectedIndex
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
    @MainActor
    func updateExerciseProgress(progress: ExerciseProgress) async {
        do {
            try await SessionDataSource.shared.updateExerciseProgress(
                for: progress,
                context: modelContext
            )
        } catch {
            print("Error updating exercise progress: \(error.localizedDescription)")
        }
    }
}


#Preview {
    @Previewable @State var showSummary = false
    @Previewable @State var progress = ExerciseProgress.new(exerciseID: ExampleData.cmeLevels[0].exercises[0].id)
    @Previewable @StateObject var settings = ThemeManager.shared
    let level = ExampleData.cmeLevels[0]
    
    NavigationStack {
        MultipleChoiceView(
            level: level,
            levelProgress: LevelProgress.new(
                levelID: level.id,
                exerciseCount: level.exercises.count
            ),
            exercise: level.exercises[0],
            isLast: true,
            showSummary: $showSummary,
            onAnswer: { anws in
                print(anws)
            },
            onLevelComplete: { }
        )
        .navigationDestination(for: ChapterLink.self) { param in
            ChapterView(params: param)
        }
    }
    .environmentObject(settings)
    .preferredColorScheme(settings.preferredColorScheme)
}
