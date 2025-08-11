//
//  SessionDataSource.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/7.
//
import Foundation
import SwiftData

actor SessionDataSource {
    static let shared = SessionDataSource()
    
    func loadLatestSession(
        for course: Course,
        context: ModelContext,
    ) throws -> CourseSessionEntity? {
        let courseID = course.id
        
        var descriptor = FetchDescriptor<CourseSessionEntity>(
            predicate: #Predicate<CourseSessionEntity> {
                $0.courseID == courseID && $0.completedAt == nil
            },
            sortBy: [SortDescriptor(\.startedAt, order: .reverse)],
        )
        descriptor.fetchLimit = 1
        
        if let existing = try context.fetch(descriptor).first {
            return existing
        }
        
        return nil
    }
    
    func fetchSessionEntity(
        from session: CourseSession,
        context: ModelContext
    ) throws -> CourseSessionEntity {
        let sessionID = session.id
        
        var descriptor = FetchDescriptor<CourseSessionEntity>(
            predicate: #Predicate<CourseSessionEntity> {
                $0.id == sessionID
            },
        )
        descriptor.fetchLimit = 1
        
        guard let entity = try context.fetch(descriptor).first else {
            throw NSError(domain: "SessionDataSource", code: 404, userInfo: [
                NSLocalizedDescriptionKey: "No matching CourseSessionEntity found for id \(session.id)"
            ])
        }
        
        return entity
    }
    
    func fetchLevelEntity(
        from level: LevelProgress,
        context: ModelContext
    ) throws -> LevelProgressEntity {
        let sessionID = level.id
        
        var descriptor = FetchDescriptor<LevelProgressEntity>(
            predicate: #Predicate<LevelProgressEntity> {
                $0.id == sessionID
            },
        )
        descriptor.fetchLimit = 1
        
        guard let entity = try context.fetch(descriptor).first else {
            throw NSError(domain: "SessionDataSource", code: 404, userInfo: [
                NSLocalizedDescriptionKey: "No matching LevelProgressEntity found for id \(level.id)"
            ])
        }
        
        return entity
    }
    
    func loadOrCreateSession(
        for course: Course,
        context: ModelContext
    ) throws -> CourseSession {
        if let sessionEntity = try loadLatestSession(for: course, context: context) {
            return sessionEntity.toModel()
        }
        
        let newSession = CourseSessionEntity(course: course)
        context.insert(newSession)
        
        try context.save()
        return newSession.toModel()
    }
    
    func loadOrCreateLevelProgress(
        session: CourseSession,
        level: ExerciseLevel,
        context: ModelContext,
    ) throws -> LevelProgress {
        // Step 1: Retrieve the corresponding entity
        let sessionEntity = try fetchSessionEntity(from: session, context: context)
        
        // Step2: Check if this level already exists
        if let existing = sessionEntity.levelProgress.first(where: { $0.levelID == level.id }) {
            return existing.toModel(withExercise: true)
        }
        
        // Step 3: create a new one
        let newEntity = LevelProgressEntity(level: level, session: sessionEntity)
        sessionEntity.levelProgress.append(newEntity)
        try context.save()
        
        return newEntity.toModel()
    }
    
    func loadOrCreateExerciseProgerss(
        levelProgress: LevelProgress,
        exercise: ExerciseV2,
        context: ModelContext
    ) throws -> ExerciseProgress {
        let levelEntity = try fetchLevelEntity(from: levelProgress, context: context)
        
        if let existing = levelEntity.exerciseProgress.first(
            where: { $0.exerciseID == exercise.id}
        ) {
            return existing.toModel()
        }
        
        
        let newEntity = ExerciseProgressEntity(
            exerciseID: exercise.id,
            level: levelEntity,
        )
        
        levelEntity.exerciseProgress.append(newEntity)
        
        try context.save()
        return newEntity.toModel()
    }
}

actor ExerciseDataSource {
    static let shared = ExerciseDataSource()
    
    func loadLevels(for course: Course) async -> [ExerciseLevel] {
        return ExerciseDataV2.allLevels[course.id] ?? []
    }
    
    func loadExercises(for course: Course, level: ExerciseLevel) async -> [ExerciseV2] {
        let levels = ExerciseDataV2.allLevels[course.id]
        
        let found = levels?.first { $0.id == level.id }
        
        return found?.exercises ?? []
    }
}
