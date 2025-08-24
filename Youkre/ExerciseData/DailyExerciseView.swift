//
//  DailyExercise.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/21.
//

import SwiftUI

struct DailyExerciseView: View {
    private let key = "dailyExercise"
    
    private var exerciseInfo: DailyExerciseInfo? {
        get {
            guard let savedData = UserDefaults.standard.data(forKey: key) else {
                return nil
            }
            
            return try? JSONDecoder().decode(DailyExerciseInfo.self, from: savedData)
        }
        
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
    
    @State private var isLoading: Bool = true
    @State private var error: String? = nil
    @State private var dailyExercise: ExerciseV2?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("每日一题")
                .font(.headline)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if isLoading {
                ProgressView()
            } else if let exercise = dailyExercise {
                PromptView(blocks: exercise.prompts)
            } else if let error {
                Text(error)
            }
        }
        .modifier(PaddedCardStyle())
    }
    
    @MainActor
    func updateDailyExerciseIfNeeded() async {
        isLoading = true
        guard let dailyExerciseInfo = exerciseInfo else {
            // 如果没有保存的数据，或者解码失败，重新获取
            await loadAndSaveNewDailyExercise()
            return
        }
        
        let currentDate = getCurrentDateAsString()
        
        if dailyExerciseInfo.lastDate != currentDate {
            // 日期变了，重新获取题目
            await loadAndSaveNewDailyExercise()
        } else {
            // 日期没变，根据 ID 获取题目
            await loadTodayExercise(dailyExerciseInfo.exerciseID)
        }
        isLoading = false
    }
    
    func loadAndSaveNewDailyExercise() async {
        do {
            let exercise = try await ExerciseDataSource.shared.fetchRandomExercise()
            dailyExercise = exercise
            
            let newExerciseInfo = DailyExerciseInfo(
                exerciseID: exercise.id,
                lastDate: getCurrentDateAsString()
            )
            // 保存到 UserDefaults
            if let encoded = try? JSONEncoder().encode(newExerciseInfo) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func loadTodayExercise(_ id: String) async {
        do {
            let exercise = try await ExerciseDataSource.shared.fetchExerciseByID(id: id)
            dailyExercise = exercise
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func getCurrentDateAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
}

#Preview {
    DailyExerciseView()
}
