//
//  DataController.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/9/16.
//

import SwiftData

// A simple singleton to hold the ModelContainer
class DataController {
    static let shared = try! ModelContainer(for: CourseSessionEntity.self)
}
