//
//  CourseSettings.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/21.
//

import Foundation

struct CourseSettings {
    static private let courseKey = "SelectedCourse"
    static private let dailyExerciseKey = "dailyExerciseInfo"
    
    static var selectedCourse: CourseKind {
        get {
            if let raw = UserDefaults.standard.string(forKey: courseKey),
               let course = CourseKind(rawValue: raw) {
                return course
            }
            
            return .all
        }
        
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: courseKey)
        }
    }
    
    static func loadDailyExercise() -> DailyExerciseInfo? {
        guard let savedData = UserDefaults.standard.data(forKey: dailyExerciseKey) else {
            return nil
        }
        
        return try? JSONDecoder().decode(DailyExerciseInfo.self, from: savedData)
    }
    
    static func saveDailyExercise(info: DailyExerciseInfo) {
        if let encoded = try? JSONEncoder().encode(info) {
            UserDefaults.standard.set(encoded, forKey: dailyExerciseKey)
        }
    }
}
