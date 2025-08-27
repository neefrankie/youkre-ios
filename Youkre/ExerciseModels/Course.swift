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
    var levelProgress: [LevelProgress]
    
    static func new(courseID: String, levelCount: Int) -> CourseSession {
        CourseSession(
            id: UUID(),
            courseID: courseID,
            startedAt: Date(),
            lastLevelIndex: levelCount > 0 ? 0 : nil,
            levelProgress: [],
        )
    }
    
    mutating func complete() {
        self.completedAt = Date()
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
    
    init(course: Course, levelCount: Int) {
        self.id = UUID()
        self.courseID = course.id
        self.startedAt = Date()
        self.lastLevelIndex = levelCount > 0 ? 0 : nil
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
            levelProgress: levelProgress.map { $0.toModel() }
        )
    }
}
