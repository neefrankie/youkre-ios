//
//  ExerciseDataSource.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/9.
//


actor ExerciseDataSource {
    static let shared = ExerciseDataSource()
    
    func loadLevels(for course: Course) async -> [ExerciseLevel] {
        return LevelData.allLevels[course.id] ?? []
    }
    
    func loadExercises(for course: Course, level: ExerciseLevel) async -> [ExerciseV2] {
        let levels = LevelData.allLevels[course.id]
        
        let found = levels?.first { $0.id == level.id }
        
        return found?.exercises ?? []
    }
}