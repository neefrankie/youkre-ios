//
//  SessionDataSource.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/7.
//
import Foundation
import SwiftData

actor SessionDataSource {
    // Currently I cannot split those methods into different classes
    // because class Entities cannot be passed out of an actor.
    static let shared = SessionDataSource()
    
    func loadLastSession(
        context: ModelContext,
        for course: Course,
    ) throws -> CourseSessionEntity? {
        
        let courseID = course.id
        
        // Find the latest used session. Since we do not turn a session into completed state,
        // it means there's at most one row for a course.
        // A course session could have multiple versions of level progress for any level
        // under it, therefore it is now suffice for user to retry all exercises.
        // If we used $0.completedAt == nil, it would aggresively create a new session once
        // we mark any session completed. This is not necessary for now.
        var descriptor = FetchDescriptor<CourseSessionEntity>(
            predicate: #Predicate<CourseSessionEntity> {
                $0.courseID == courseID
            },
            sortBy: [SortDescriptor(\.startedAt, order: .reverse)],
        )
        descriptor.fetchLimit = 1
        
        if let existing = try context.fetch(descriptor).first {
            return existing
        }
        
        return nil
    }
    
    func loadOrCreateSession(
        context: ModelContext,
        for course: Course,
    ) throws -> (CourseSession, [LevelProgress]) {
        
        if let sessionEntity = try loadLastSession(
            context: context,
            for: course,
        ) {
            
            if sessionEntity.courseContentVersion == course.contentVersion {
                return (sessionEntity.toModel(), sessionEntity.toLevelModel())
            } else {
                context.delete(sessionEntity)
            }
        }
        
        // Create a new session
        let newSession = CourseSessionEntity(
            course: course,
        )
        context.insert(newSession)
        
        try context.save()
        
        return (newSession.toModel(), [])
    }
    
    func updateSession(
        context: ModelContext,
        from session: CourseSession,
    ) throws {
        if let entity = try findSessionEntity(
            context: context,
            for: session,
        ) {
            entity.update(from: session)
            
            try context.save()
            print("updateSession finished")
        } else {
            print("updateSession not found entity")
        }
    }
    
    func findSessionEntity(
        context: ModelContext,
        for session: CourseSession,
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
    
    // ========= LevelProgressEntity ==========
    
    func findLastLevel(
        context: ModelContext,
        for level: ExerciseLevel,
        ofCourse session: CourseSession,
    ) throws -> LevelProgressEntity? {
        
        let sessionID = session.id
        // A level might have multiple level progress under the same course session.
        // But there should be only one that is not completed.
        let levelID = level.id
        
        // If we used $0.completedAt == nil in the predicate, it would aggresively create
        // a level progress once user complete the last exercise in this level, without a chance of review.
        var descriptor = FetchDescriptor<LevelProgressEntity>(
            predicate: #Predicate<LevelProgressEntity> {
                $0.levelID == levelID && $0.courseSessionID == sessionID
            },
            sortBy: [SortDescriptor(\.startedAt, order: .reverse)],
        )
        descriptor.fetchLimit = 1
        
        if let existing = try context.fetch(descriptor).first {
            return existing
        }
        
        return nil
    }
    
    func createLevelProgres(
        context: ModelContext,
        for level: ExerciseLevel,
        ofCourse session: CourseSession,
        exerciseCount: Int,
    ) throws -> LevelProgress {
        // Step 1: Retrieve the source session
        if let sessionEntity = try findSessionEntity(
            context: context,
            for: session
        ) {
            // Step 3: create a new one
            let newEntity = LevelProgressEntity(
                for: level,
                exerciseCount: exerciseCount,
                ofCourse: sessionEntity
            )
            sessionEntity.levelProgress.append(newEntity)
            try context.save()
            
            print("Create new level progress")
            return newEntity.toModel()
        }
        
        // fallback.
        print("Create in-memory level progress.")
        return LevelProgress.new(
            levelID: level.id,
            exerciseCount: exerciseCount
        )
    }
    
    // Load the latest not-completed LevelProgressEntity for a ExerciseLevel under a CourseSession.
    func loadOrCreateLevelProgress(
        context: ModelContext,
        for level: ExerciseLevel,
        ofCourse session: CourseSession,
        exerciseCount: Int,
    ) throws -> (LevelProgress, [ExerciseProgress]) {
        
        // Check if this level already exists
        if let levelEntity = try findLastLevel(
            context: context,
            for: level,
            ofCourse: session,
        ) {
            if levelEntity.levelContentVersion == level.contentVersion {
                print("Use existing level progress.")
                return (levelEntity.toModel(), levelEntity.toExerciseModel())
            } else {
                print("Deleting imcompatible level progress")
                context.delete(levelEntity)
                // Proceed to create new one.
            }
        }
        
        // Create a new one.
        // Step 1: Retrieve the source session
        if let sessionEntity = try findSessionEntity(
            context: context,
            for: session
        ) {
            // Step 3: create a new one
            let newEntity = LevelProgressEntity(
                for: level,
                exerciseCount: exerciseCount,
                ofCourse: sessionEntity
            )
            sessionEntity.levelProgress.append(newEntity)
            try context.save()
            
            print("Create new level progress")
            return (newEntity.toModel(), [])
        }
        
        // fallback.
        print("Create in-memory level progress.")
        return (LevelProgress.new(
            levelID: level.id,
            exerciseCount: exerciseCount
        ), [])
    }
    
    func findLevelEntity(
        context: ModelContext,
        for level: LevelProgress,
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
        context: ModelContext,
        from progress: LevelProgress,
    ) throws {
        if let entity = try findLevelEntity(
            context: context,
            for: progress
        ){
            entity.update(from: progress)
            
            try context.save()
            print("DB: updateed level progress finished")
        } else {
            print("DB: updateLevelProgress not found entity")
        }
    }
    
    
    
    // ====== ExerciseProgress =========
    
    func createExerciseProgress(
        context: ModelContext,
        for exercise: Exercise,
        ofLevel levelProgress: LevelProgress,
    ) throws -> ExerciseProgress {
        // Find the entity corresponding to LevelProgress
        // ExerciseProgress is attached to LevelProgress, so we need to start from LevelProgressEntity.
        if let levelEntity = try findLevelEntity(
            context: context,
            for: levelProgress
        ) {
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
    func findExerciseEntity(
        context: ModelContext,
        for progress: ExerciseProgress,
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
        context: ModelContext,
        from progress: ExerciseProgress,
    ) throws {
        if let entity = try findExerciseEntity(
            context: context,
            for: progress,
        ) {
            entity.update(from: progress)
            
            try context.save()
            print("DB: Updated exercise progress")
        } else {
            print("DB: No existing exercise progress to update")
        }
    }
}


