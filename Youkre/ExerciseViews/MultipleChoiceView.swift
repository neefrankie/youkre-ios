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
    let exercise: ExerciseV2
    let isLast: Bool
    @Binding var showSummary: Bool
    var onAnswer: (ExerciseProgress) -> Void
    var onLevelComplete: () -> Void
    
    @State private var isLoading: Bool = true
    @State private var error: String? = nil
    @State private var currentProgress: ExerciseProgress? = nil
    
    @State private var selectedIndex: Int? = nil
    @State private var showExplanation = false
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
            await loadExerciseProgress()
        }
    }
    
    @ViewBuilder
    private func detailView(progress: ExerciseProgress) -> some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    PromptView(blocks: exercise.prompts)
                    
                    ForEach(exercise.multipleChoice.choices.indices, id: \.self) { i in
                        Button(action: {
                            selectedIndex = i
                            checkAnswer(
                                correctIndex: exercise.multipleChoice.correctIndex
                            )
                        }) {
                            choiceItemView(
                                choice: exercise.multipleChoice.choices[i],
                                isLatex: exercise.multipleChoice.isLatex,
                                currentIndex: i,
                                correctIndex: exercise.multipleChoice.correctIndex
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
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                NavigationLink(value: level.learnMore) {
                    Label("理论", systemImage: "book")
                }
                
                Spacer()
                
                Button{
                    
                } label: {
                    Label("分享", systemImage: "square.and.arrow.up")
                }
                
                Spacer()
                
                Button {
                    showExplanation = true
                } label: {
                    Label("解析", systemImage: "questionmark")
                        
                }
            }
        }
    }
    
    @ViewBuilder
    private func choiceItemView(
        choice: String,
        isLatex: Bool,
        currentIndex: Int,
        correctIndex: Int
    ) -> some View {
        HStack {
            if isLatex {
                MathView(
                    latex: choice,
                    fontSize: 20,
                    labelMode: .text,
                    textAlignment: .left,
                    textColor: .primary
                )
                .fixedSize()
            } else {
                Text(choice)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.trailing, 20)
                    .foregroundColor(.primary)
            }
            
            // This also makes the button full width.
            Spacer()
            
            trailingImage(
                for: currentIndex,
                correctIndex: correctIndex,
            )
            .frame(width: 20, height: 20)
        }
        .padding()
        .background(
            buttonColor(
                for: currentIndex,
                correctIndex: correctIndex
            )
            .animation(
                .easeInOut(duration: 0.4),
                value: selectedIndex,
            )
        )
        .cornerRadius(8)
        .shadow(radius: 2)
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
                // Implicilty indicated this index != correcIndex
                // index is not the correntIndex but is selected, so it's not correct.
                return .red.opacity(0.3)
            }
        }
        
//        return .gray.opacity(0.1)
        return AppColors.contentBackground
    }
    
    @MainActor
    func loadExerciseProgress() async {
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
    @Previewable @State var progress = ExerciseProgress.new(exerciseID: ExerciseData.calculus[0].id)
    @Previewable @StateObject var settings = ThemeManager.shared
    let level = LevelData.cme[0]
    
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
