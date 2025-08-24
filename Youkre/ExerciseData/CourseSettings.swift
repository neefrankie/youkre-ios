//
//  CourseSettings.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/21.
//

import Foundation

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
