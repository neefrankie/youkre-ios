//
//  AppSettings.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/11.
//

import Foundation

struct AppSettings {
    static let courseKey = "SelectedCourse"
    
    static var selectedCourse: Course {
        get {
            if let raw = UserDefaults.standard.string(forKey: courseKey),
               let course = Course(rawValue: raw) {
                return course
            }
            
            return .algebra
        }
        
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: courseKey)
        }
    }
}
