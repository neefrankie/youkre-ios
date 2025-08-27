//
//  DailyExercise.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/21.
//

import SwiftUI

struct DailyExerciseView: View {
    @State private var isLoading: Bool = true
    @State private var error: String? = nil
    @State private var dailyExercise: Exercise?
    @State private var exerciseLevel: ExerciseLevel?
    
    @State private var showCourseSelection = false
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else if let exercise = dailyExercise, let level = exerciseLevel {
                VStack {
                    HStack {
                        Spacer()
                        Text("每日一题")
                            .font(.headline)
                            .foregroundColor(.primary)
                            
                        Spacer()
                        
                        Button(action: {
                            showCourseSelection = true
                        }) {
                            Image(systemName: "gear")
                                .foregroundColor(.primary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    NavigationLink(
                        value: DailyExerciseParam(
                            exercise: exercise,
                            level: level
                        )
                    ) {
                        DailyExerciseCardView(
                            exercise: exercise
                        )
                    }
                }
                
            } else if let error {
                Text(error)
            }
        }
        .sheet(isPresented: $showCourseSelection) {
            CourseSelectionSheet(
                onSwitchCourse: onSwitchCourse
            )
        }
        .task {
            await updateDailyExerciseIfNeeded()
        }
    }
    
    @MainActor
    func updateDailyExerciseIfNeeded() async {
        let courseKind = CourseSettings.selectedCourse
        
        guard let dailyExerciseInfo = CourseSettings.loadDailyExercise() else {
            // 如果没有保存的数据，或者解码失败，重新获取
            await loadAndSaveNewDailyExercise(kind: courseKind)
            return
        }
        
        let currentDate = DailyExerciseInfo.getCurrentDateAsString()
        
        if dailyExerciseInfo.lastDate != currentDate {
            // 日期变了，重新获取题目
            await loadAndSaveNewDailyExercise(kind: courseKind)
        } else {
            // 日期没变，根据 ID 获取题目
            await loadTodayExercise(dailyExerciseInfo.exerciseID)
        }
    }
    
    func onSwitchCourse(kind: CourseKind) {
        print("Course switched: \(kind)")
        CourseSettings.selectedCourse = kind
        Task {
            await loadAndSaveNewDailyExercise(kind: kind)
        }
    }
    
    func loadAndSaveNewDailyExercise(kind: CourseKind) async {
        isLoading = true
        do {
            let exercise = try await ExerciseDataSource.shared.fetchRandomExercise(kind: kind)
            let level = try await ExerciseDataSource.shared.fetchLevelByID(id: exercise.levelId)
            
            self.exerciseLevel = level
            self.dailyExercise = exercise
            
            print("Daily exercise changed \(exercise.id)")
            
            let newExerciseInfo = DailyExerciseInfo.new(
                exerciseID: exercise.id,
            )
            // 保存到 UserDefaults            
            CourseSettings.saveDailyExercise(info: newExerciseInfo)
        } catch {
            print(error)
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    func loadTodayExercise(_ id: String) async {
        isLoading = true
        do {
            let exercise = try await ExerciseDataSource.shared.fetchExerciseByID(id: id)
            let level = try await ExerciseDataSource.shared.fetchLevelByID(id: exercise.levelId)
            
            self.exerciseLevel = level
            self.dailyExercise = exercise
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}

#Preview {
    NavigationStack {
        DailyExerciseView()
            .padding()
    }
}
