//
//  LevelDetailView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/8.
//

import SwiftUI
import SwiftData

struct LevelDetailView: View {
//    let levelParams: LevelDetailParams
    @Bindable var courseViewModel: CourseViewModel
    @Binding var path: NavigationPath
    
    @State private var viewModel = LevelViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showButton = false
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if let levelProgress = viewModel.levelProgress {
                VStack {
                    HStack {
                        Text("\(viewModel.progressText)")
                    }
                    
                    TabView(selection: $viewModel.selectedTabIndex) {
                        ForEach(viewModel.exercises.indices, id: \.self) { index in
                            let exercise = viewModel.exercises[index]
                            
                            ExerciseDetailView(
                                exercise: exercise,
                                levelProgress: levelProgress,
                                exerciseProgress: viewModel.getExerciseProgress(exerciseID: exercise.id),
                                isLast: viewModel.isLast,
                                onAnswer: viewModel.updateLevelProgress,
                            )
                            .tag(index)
                        }
                        
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .indexViewStyle(.page(backgroundDisplayMode: .never))
                    
                    if showButton {
                        Button(action: viewModel.onSummary) {
                            Label("完成", systemImage: "")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(CapsuleButtonStyle())
                        .padding()
                        .padding(.bottom, 16)
                        .transition(.scale(scale: 0.9).combined(with: .opacity))
                    }
                    
                }
                
            } else if let error = viewModel.error {
                Text(error)
            }
        }
        .onChange(of: viewModel.isLast && viewModel.lastAnswered) { (oldValue, newValue) in
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                showButton = newValue
            }
        }
        .navigationTitle(courseViewModel.navTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Label("Back", systemImage: "xmark")
                }
                
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("下一题") {
                    viewModel.advance()
                }
                .disabled(viewModel.isLast)
            }
            ToolbarItem(placement: .bottomBar) {
                if let level = courseViewModel.currentLevel, let exercise = viewModel.currentExercise {
                    ExerciseBottomBar(
                        level: level,
                        exercise: exercise
                    )
                }
            }
        }
        .sheet(isPresented: $viewModel.showSummary) {
            LevelSummarySheet(
                levelProgress: viewModel.levelProgress,
                hasNextLevel: courseViewModel.hasNextLevel,
                allLevelsComplete: courseViewModel.allLevelsComplete,
                onRestart: self.onRestart,
                onNextLevel: self.onNextLevel,
                onFinish: self.onFinish,
            )
        }
        .onAppear {
            loadLevelAndExercises()
            // When user clicked a level randomly, update the last level index.
            courseViewModel.updateSession()
        }
    }
    
    private func loadLevelAndExercises() {
        viewModel.loadData(
            for: courseViewModel.currentLevel,
            of: courseViewModel.session,
            course: courseViewModel.course,
        )
    }
        
    // Create a new level progress.
    private func onRestart() {
        let prevLevelProgress = viewModel.restartCurrentLevel(
            for: courseViewModel.currentLevel,
            of: courseViewModel.session,
            course: courseViewModel.course,
        )
        
        // level progress should be updated to completed when reaching here.
        if let prevLevelProgress {
            courseViewModel.addCompletedLevel(
                levelProgress: prevLevelProgress
            )
        }
    }
    
    // Callback
    private func onNextLevel() {
        print("Go to next level")
        
        let nextLevel = courseViewModel.moveToNextLevel()
        
        let prevLevelProgress = viewModel.startNewLevel(
            for: nextLevel,
            of: courseViewModel.session,
            course: courseViewModel.course
        )
        
        if let prevLevelProgress {
            courseViewModel.addCompletedLevel(
                levelProgress: prevLevelProgress
            )
        }
        
        courseViewModel.updateSession()
    }
    
    // All levels finished.
    private func onFinish() {
        if !path.isEmpty {
            // Simply remove or append to path is safe.
            path.removeLast()
        }
    }
    
    
}

#Preview {
    @Previewable @StateObject var themeManager = ThemeManager.shared
    @Previewable @State var courseViewModel = CourseViewModel.mock(course: ExampleData.courses[0])
    @Previewable @State var path = NavigationPath()
    
    NavigationStack(path: $path) {
        LevelDetailView(
            courseViewModel: courseViewModel,
            path: $path,
        )
        .navigationDestination(for: ChapterLink.self) { params in
            ChapterView(params: params)
        }
    }
    .environmentObject(themeManager)
    .preferredColorScheme(themeManager.preferredColorScheme)
    .modelContainer(for: [CourseSessionEntity.self], inMemory: true)
}
