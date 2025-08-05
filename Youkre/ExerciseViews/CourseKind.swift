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

