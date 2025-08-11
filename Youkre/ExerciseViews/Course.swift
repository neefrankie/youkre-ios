//
//  Course.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/11.
//

import Foundation

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

struct Course {
    let id: String
    let slug: String
    let title: String
    
    static let all: [Course] = [
        Course(
            id: "5bd2c24bd901b5a9",
            slug: "calculus-made-easy",
            title: "简易微积分",
        ),
        Course(
            id: "6b927048e42cc585",
            slug: "elementary-algebra",
            title: "初级代数",
        ),
//        Course(
//            id: "ad7dd3035d82eda3",
//            slug: "elementary-statistics",
//            title: "概率统计入门",
//        ),
//        Course(
//            id: "9b08c5f3f19338c4",
//            slug: "elementary-trigonometry",
//            title: "三角函数",
//        )
    ]
}
