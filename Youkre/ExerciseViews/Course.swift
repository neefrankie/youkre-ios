//
//  Course.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/11.
//

enum Course: String, CaseIterable, Identifiable, Codable {
    case algebra
    case calculus
    case probability
    case trigonometry
//    case geometry      // 几何
//    case physics       // 物理
    
    var id: String {
        rawValue
    }
    
    var title: String {
        switch self {
        case .algebra: return "代数"
        case .calculus: return "微积分"
        case .probability: return "概率"
        case .trigonometry: return "三角函数"
        }
    }
}
