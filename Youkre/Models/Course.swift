//
//  Course.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/11.
//

import Foundation
import SwiftData

struct Course: Identifiable, Hashable {
    let id: String
    let slug: String
    let title: String
    var summary: String? = nil
    var keywords: String? = nil
    var icons: IconSymbol? = nil
    var exerciseCover: String
    var contentVersion: Int = 1
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(slug)
    }
    
    static func ==(lhs: Course, rhs: Course) -> Bool {
        return lhs.id == rhs.id
    }
}

struct CourseSession {
    var id: UUID
    var courseID: String
    var startedAt: Date
    var completedAt: Date?
    var lastLevelIndex: Int?
    
    var isCompleted: Bool {
        return completedAt != nil
    }
    
    static func new(courseID: String) -> CourseSession {
        CourseSession(
            id: UUID(),
            courseID: courseID,
            startedAt: Date(),
            completedAt: nil,
            lastLevelIndex: nil,
        )
    }
    
    mutating func markComplete() {
        self.completedAt = Date()
    }
    
    mutating func advanceLevel(maxIndex: Int) {
        if let current = lastLevelIndex {
            if current < maxIndex {
                lastLevelIndex = current + 1;
            }
        } else {
            if maxIndex >= 0 {
                lastLevelIndex = 0
            }
        }
    }
    
    mutating func changeLevel(toLevelIndex: Int, maxIndex: Int) {
        if toLevelIndex <= maxIndex {
            lastLevelIndex = toLevelIndex
        }
    }
}

@Model
class CourseSessionEntity {
    @Attribute(.unique) var id: UUID
    var courseID: String
    var startedAt: Date
    var completedAt: Date?
    var lastLevelIndex: Int?
    var courseContentVersion: Int
    
    // levels is a 1:N relationship to LevelProgressEntity
    // .cascade ensures cleanup on delete
    @Relationship(deleteRule: .cascade)
    var levelProgress: [LevelProgressEntity] = []
    
    init(course: Course) {
        self.id = UUID()
        self.courseID = course.id
        self.startedAt = Date()
        self.lastLevelIndex = nil
        self.courseContentVersion = course.contentVersion
    }
    
    func update(from model: CourseSession) {
        self.completedAt = model.completedAt
        self.lastLevelIndex = model.lastLevelIndex
    }
    
    func toModel() -> CourseSession {
        CourseSession(
            id: id,
            courseID: courseID,
            startedAt: startedAt,
            completedAt: completedAt,
            lastLevelIndex: lastLevelIndex,
        )
    }
    
    func toLevelModel() -> [LevelProgress] {
        levelProgress.map { $0.toModel() }
    }
}
