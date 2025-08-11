//
//  Course.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/11.
//

import Foundation
import SwiftData

enum CourseKind: String, CaseIterable, Identifiable, Codable {
    case calculus
    case algebra
    case probability
    case trigonometry
//    case geometry      // 几何
//    case physics       // 物理
    
    var id: String {
        rawValue
    }
    
    var title: String {
        switch self {
        case .calculus: return "微积分"
        case .algebra: return "代数"
        case .probability: return "概率"
        case .trigonometry: return "三角函数"
        }
    }
}


struct CourseSettings {
    static let courseKey = "SelectedCourse"
    
    static var selectedCourse: CourseKind {
        get {
            if let raw = UserDefaults.standard.string(forKey: courseKey),
               let course = CourseKind(rawValue: raw) {
                return course
            }
            
            return .calculus
        }
        
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: courseKey)
        }
    }
}

struct Course: Identifiable, Hashable {
    let id: String
    let slug: String
    let title: String
    var contentVersion: Int = 1
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(slug)
    }
    
    static func ==(lhs: Course, rhs: Course) -> Bool {
        return lhs.id == rhs.id
    }
    
    static let all: [Course] = [
        Course(
            id: "5bd2c24bd901b5a9",
            slug: "calculus-made-easy",
            title: "简易微积分",
            contentVersion: 1,
        ),
        Course(
            id: "6b927048e42cc585",
            slug: "elementary-algebra",
            title: "初级代数",
            contentVersion: 1,
        ),
        Course(
            id: "ad7dd3035d82eda3",
            slug: "elementary-statistics",
            title: "概率统计入门",
            contentVersion: 1,
        ),
        Course(
            id: "9b08c5f3f19338c4",
            slug: "elementary-trigonometry",
            title: "三角函数",
            contentVersion: 1,
        )
    ]
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
