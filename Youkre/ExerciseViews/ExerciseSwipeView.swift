//
//  ExerciseSwipeView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/11.
//

import SwiftUI

struct ExerciseSwipeView: View {
    @StateObject var session = ExerciseSessionModel(allExercises: sampleExercises)
    
    @State private var showCourseSheet = false
    @State private var showSummary = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if session.exercises.isEmpty {
                    Text("没有这个课程的题目")
                } else {
                    HStack {
                        Text("\(session.progressText)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    
                    TabView(selection: $session.currentIndex) {
                        ForEach(session.exercises.indices, id: \.self) { i in
                            Group {
                                
                                switch session.exercises[i].type {
                                case .fillInTheBlank:
                                    FillInBlankView(
                                        currentExercise: session.exercises[i],
                                        currentState: $session.currentState,
                                    )
                                    
                                case .multipleChoice:
                                    MultipleChoiceView(
                                        exercise: session.exercises[i],
                                        currentState: $session.currentState,
                                    )
                                }
                            }
                            .tag(i)
                        }
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .never))
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("课程") {
                        showCourseSheet = true
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    if session.isFinished {
                        Button("总结") {
                            showSummary = true
                        }
                    } else {
                        Button("下一题") {
                            session.next()
                        }
                    }
                    
                }
            }
            .sheet(isPresented: $showCourseSheet) {
                CourseSelectionSheet(selectedCourse: $session.selectedCourse)
            }
            .sheet(isPresented: $showSummary) {
                ExerciseSummaryView(session: session)
            }
        }
        .background(AppColors.background)
    }
}

#Preview {
    @Previewable @StateObject var settings = ThemeManager.shared
    
    ExerciseSwipeView()
        .environmentObject(settings)
        .preferredColorScheme(settings.preferredColorScheme)
}
