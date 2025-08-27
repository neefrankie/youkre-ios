//
//  CourseKind.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/21.
//


enum CourseKind: String, CaseIterable, Identifiable, Codable {
    case all
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
        case .all: return "所有"
        case .calculus: return "微积分"
        case .algebra: return "代数"
        case .probability: return "概率"
        case .trigonometry: return "三角函数"
        }
    }
}
