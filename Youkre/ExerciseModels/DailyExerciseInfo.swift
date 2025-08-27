//
//  DailyExercise.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/21.
//

import Foundation

struct DailyExerciseInfo: Codable {
    let exerciseID: String
    let lastDate: String
    var selectedIndex: Int? = nil
    
    static func new(exerciseID: String, selected: Int? = nil) -> DailyExerciseInfo {
        return DailyExerciseInfo(
            exerciseID: exerciseID,
            lastDate: getCurrentDateAsString(),
            selectedIndex: selected
        )
    }
    
    static func getCurrentDateAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
}

struct DailyExerciseParam: Hashable {
    let exercise: Exercise
    let level: ExerciseLevel
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(exercise.id)
    }
}
