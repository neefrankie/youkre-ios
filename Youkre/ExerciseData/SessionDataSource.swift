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
    ) throws -> CourseSessionEntity? {
        let sessionID = session.id
        
        var descriptor = FetchDescriptor<CourseSessionEntity>(
            predicate: #Predicate<CourseSessionEntity> {
                $0.id == sessionID
            },
        )
        descriptor.fetchLimit = 1
        
        if let existing = try context.fetch(descriptor).first {
            return existing
        }
        
        return nil
    }
    
    func updateSession(
        from session: CourseSession,
        context: ModelContext
    ) throws {
        if let entity = try fetchSessionEntity(from: session, context: context) {
            entity.update(from: session)
            
            try context.save()
            print("updateSession finished")
        } else {
            print("updateSession not found entity")
        }
    }
    
    func loadOrCreateSession(
        for course: Course,
        levelCount: Int,
        context: ModelContext
    ) throws -> CourseSession {
        if let sessionEntity = try loadLatestSession(for: course, context: context) {
            if sessionEntity.courseContentVersion == course.contentVersion {
                return sessionEntity.toModel()
            } else {
                context.delete(sessionEntity)
            }
        }
        
        let newSession = CourseSessionEntity(
            course: course,
            levelCount: levelCount
        )
        context.insert(newSession)
        
        try context.save()
        
        return newSession.toModel()
    }
    
    // Manipulate LevelProgressEntity
    
    func fetchLevelEntity(
        from level: LevelProgress,
        context: ModelContext
    ) throws -> LevelProgressEntity? {
        let sessionID = level.id
        
        var descriptor = FetchDescriptor<LevelProgressEntity>(
            predicate: #Predicate<LevelProgressEntity> {
                $0.id == sessionID
            },
        )
        descriptor.fetchLimit = 1
        
        if let entity = try context.fetch(descriptor).first {
            return entity
        }
        
        return nil
    }
    
    func updateLevelProgress(
        for progress: LevelProgress,
        context: ModelContext,
    ) throws {
        if let entity = try fetchLevelEntity(from: progress, context: context) {
            entity.update(from: progress)
            
            try context.save()
            print("updateLevelProgress finished")
        } else {
            print("updateLevelProgress not found entity")
        }
    }
    
    func fetchLatestLevelEntity(
        for session: CourseSession,
        level: ExerciseLevel,
        context: ModelContext,
    ) throws -> LevelProgressEntity? {
        let sessionID = session.id
        // A level might have multiple level progress under the same course session.
        // But there should be only one that is not completed.
        let levelID = level.id
        
        var descriptor = FetchDescriptor<LevelProgressEntity>(
            predicate: #Predicate<LevelProgressEntity> {
                $0.levelID == levelID && $0.courseSessionID == sessionID && $0.completedAt == nil
            },
            sortBy: [SortDescriptor(\.startedAt, order: .reverse)],
        )
        descriptor.fetchLimit = 1
        
        if let existing = try context.fetch(descriptor).first {
            return existing
        }
        
        return nil
    }
    
    // Load the latest not-completed LevelProgressEntity for a ExerciseLevel under a CourseSession.
    func loadOrCreateLevelProgress(
        for level: ExerciseLevel,
        exerciseCount: Int,
        of session: CourseSession,
        context: ModelContext,
    ) throws -> LevelProgress {
        
        // Check if this level already exists
        if let levelEntity = try fetchLatestLevelEntity(for: session, level: level, context: context) {
            if levelEntity.levelContentVersion == level.contentVersoin {
                print("loadOrCreatedLevelProgress existing")
                return levelEntity.toModel(withExercise: true)
            } else {
                print("loadOrCreateLevelProgress: Deleting imcompatible level progress")
                context.delete(levelEntity)
                // Proceed to create new one.
            }
        }
        
        // Create a new one.
        // Step 1: Retrieve the source session
        if let sessionEntity = try fetchSessionEntity(from: session, context: context) {
            // Step 3: create a new one
            let newEntity = LevelProgressEntity(
                for: level,
                exerciseCount: exerciseCount,
                of: sessionEntity
            )
            sessionEntity.levelProgress.append(newEntity)
            try context.save()
            
            print("loadOrCreateLevelProgress: created")
            return newEntity.toModel()
        }
        
        // fallback.
        print("loadOrCreateLevelProgress: create in-memory level progress.")
        return LevelProgress.new(levelID: level.id, exerciseCount: exerciseCount)
    }
    
// ExerciseProgress is attached to LevelProgress, so we need to start from LevelProgressEntity.
    func loadOrCreateExerciseProgress(
        levelProgress: LevelProgress,
        exercise: Exercise,
        context: ModelContext
    ) throws -> ExerciseProgress {
        // Find the entity corresponding to LevelProgress
        if let levelEntity = try fetchLevelEntity(from: levelProgress, context: context) {
            if let existing = levelEntity.exerciseProgress.first(
                // Find the exercise progress entity for this exercise.
                where: { $0.exerciseID == exercise.id}
            ) {
                print("Use exsiting exercise progress")
                return existing.toModel()
            }
            
            // Create new one
            let newEntity = ExerciseProgressEntity(
                exerciseID: exercise.id,
                level: levelEntity,
            )
            levelEntity.exerciseProgress.append(newEntity)
            
            try context.save()
            print("Created new exercise progress")
            return newEntity.toModel()
        }
        
        // Fallback.
        print("Unable to access db. Create in-memory exercise progress")
        return ExerciseProgress.new(exerciseID: exercise.id)
    }
    
    
    // Retrieve ExerciseProgressEntity by id.
    func fetchExerciseEntity(
        from progress: ExerciseProgress,
        context: ModelContext
    ) throws -> ExerciseProgressEntity? {
        
        let progressID = progress.id
        
        var descriptor = FetchDescriptor<ExerciseProgressEntity>(
            predicate: #Predicate<ExerciseProgressEntity> {
                $0.id == progressID
            },
        )
        descriptor.fetchLimit = 1
        
        if let entity = try context.fetch(descriptor).first {
            return entity
        }
        
        return nil
    }
    
    func updateExerciseProgress(
        for progress: ExerciseProgress,
        context: ModelContext,
    ) throws {
        if let entity = try fetchExerciseEntity(from: progress, context: context) {
            entity.update(from: progress)
            
            try context.save()
            print("Updated exercise progress")
        } else {
            print("No existing exercise progress to update")
        }
    }
}


