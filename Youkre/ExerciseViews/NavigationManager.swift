//
//  NavigationManager.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/11.
//

import SwiftUI

@Observable
class NavigationManager {
    var courseViewModels: [String: CourseViewModel] = [:]
    
    func getOrCreateCourseViewModel(for course: Course) -> CourseViewModel {
        if let existingViewModel = courseViewModels[course.id] {
            return existingViewModel
        } else {
            let newViewModel = CourseViewModel(course: course)
            courseViewModels[course.id] = newViewModel
            return newViewModel
        }
    }
    
    func getCourseViewModel(by id: String) -> CourseViewModel? {
        return courseViewModels[id]
    }
    
    func cleanUp(id: String) {
        courseViewModels.removeValue(forKey: id)
    }
}
