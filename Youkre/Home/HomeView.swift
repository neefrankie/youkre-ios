//
//  HomeView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/6.
//

import SwiftUI

struct HomeView: View {
    @State private var path = NavigationPath()
    @State private var navigationManager = NavigationManager()
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView(showsIndicators: false) {
                VStack {
                    DailyExerciseView()
                    
                    CourseListView()
                }
                .padding()
            }
            .navigationDestination(for: Course.self) { course in
                let viewModel = navigationManager.getOrCreateCourseViewModel(for: course)
                CourseDetailView(
                    viewModel: viewModel,
                    path: $path,
                )
            }
            .navigationDestination(for: ExerciseLevel.self) { level in
                if let viewModel = navigationManager.getCourseViewModel(by: level.courseID) {
                    LevelDetailView(
                        courseViewModel: viewModel,
                        path: $path
                    )
                }
            }
            .navigationDestination(for: ChapterLink.self) { params in
                ChapterView(params: params)
            }
            .navigationDestination(for: DailyExerciseParam.self) { param in
                DailyExerciseDetailView(param: param)
            }
            .navigationTitle(Config.appName)
            .navigationBarTitleDisplayMode(.inline)
        }
        .background(AppColors.background)
    } 
}

#Preview {
    @Previewable @StateObject var themeManager = ThemeManager.shared
    HomeView()
        .environmentObject(themeManager)
        .preferredColorScheme(themeManager.preferredColorScheme)
}
