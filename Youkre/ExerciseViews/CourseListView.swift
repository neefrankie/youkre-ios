//
//  CourseLauncherView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/6.
//

import SwiftUI
import SwiftData

@MainActor
final class CourseLauncherViewModel: ObservableObject {
    let course: Course
    @Published var isLoading = true
    @Published var error: String? = nil
    @Published var levelViewModel: ExerciseLevelViewModel?
    
    @Published var session: CourseSession? // Contains session and level progress corresponding to each ExerciseLevel.
    @Published var levels: [ExerciseLevel] = []
    @Published var existingLevelStates: [String: LevelProgress] = [:]
    
//    @Published var currentLevelIndex: Int = 0
//    var currentLevel: ExerciseLevel {
//        levels[currentLevelIndex]
//    }
    
//    var finished: Bool {
//        currentLevelIndex == levels.count - 1
//    }
    
    init(course: Course) {
        self.course = course
    }
    
    
    
    func loadSession(context: ModelContext) async {
        isLoading = true
        do {
            // Load exercises for this course
            let levels = await ExerciseDataSource.shared.loadLevels(for: course)
            
            // Check of create a SwiftData session
            let session = try await SessionDataSource.shared.loadOrCreateSession(
                for: course,
                context: context
            )
            
            self.levels = levels
            self.session = session
            
            self.existingLevelStates = Dictionary(uniqueKeysWithValues: session.levelProgress.map { (key: $0.levelID, value: $0) })
            
//            var lastLevelIndex = session.lastLevelIndex ?? 0
//            if lastLevelIndex >= levels.count {
//                lastLevelIndex = 0
//            }
//            self.currentLevelIndex = lastLevelIndex

//            let currentLevelProgress = session.levelProgress[lastLevelIndex]
            
//            let model = ExerciseLevelViewModel(
//                course: course,
//                level: levels[lastLevelIndex],
//                levelProgress: currentLevelProgress,
//            )
//            self.levelViewModel = model
        } catch {
            print("Failed to load session: \(error)")
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
//    func switchToLevel(_ index: Int) {
//        guard index >= 0, index < levels.count else {
//            return
//        }
//        
//        currentLevelIndex = index
//    }
    
//    func proceedToNextLevel() {
//        print("Go to next level")
//        switchToLevel(currentLevelIndex + 1)
//    }
}

struct CourseListView: View {
    @StateObject private var viewModel: CourseLauncherViewModel
    @Environment(\.modelContext) var modelContext
    
    init(course: Course) {
        _viewModel = StateObject(
            wrappedValue: CourseLauncherViewModel(course: course)
        )
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading session...")
            } else if viewModel.session != nil {
                List {
                    ForEach(viewModel.levels) { level in
                        NavigationLink(value: level) {
                            Text("\(level.index)")
                        }
                    }
                }
                Text("Hello")
            } else if let error = viewModel.error {
                Text(error)
            }
        }
        .task {
            await viewModel.loadSession(context: modelContext)
        }
    }
}



#Preview {
    CourseListView(course: Course.all[0])
        .modelContainer(
            for: [CourseSessionEntity.self],
            inMemory: true
        )
}
