//
//  FontSize.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/15.
//

enum FontSize: String, CaseIterable, Identifiable {
    case small
    case medium
    case large
    case xlarge
    
    var id: String {
        self.rawValue
    }
    
    var displayName: String {
        switch self {
        case .small:
            return "小"
        case .medium:
            return "中"
        case .large:
            return "大"
        case .xlarge:
            return "超大"
        }
    }
}
