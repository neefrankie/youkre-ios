//
//  ExerciseSwipeView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/11.
//

import SwiftUI

struct ExerciseSwipeView: View {
    @StateObject var session = ExerciseSessionModel()
    
    @State private var showCourseSheet = false
    @State private var showSummary = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if session.exercises.isEmpty {
                    Text("没有这个课程的题目")
                } else {
                    
                    TabView(selection: $session.currentIndex) {
                        ForEach(session.exercises.indices, id: \.self) { index in
//                            MultipleChoiceView(
//                                exercise: session.exercises[index],
//                                currentState: session.binding(for: session.exercises[index].id)
//                            )
//                            .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .indexViewStyle(.page(backgroundDisplayMode: .never))
                }
                
            }
            .navigationTitle("\(session.progressText)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("课程") {
                        showCourseSheet = true
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    if session.finished {
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
                CourseSelectionSheet(
                    selectedCourse: $session.selectedCourse,
                )
            }
            .sheet(isPresented: $showSummary) {
                ExerciseSummarySheet(session: session)
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
