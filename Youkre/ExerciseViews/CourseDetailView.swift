//
//  ExerciseSwipingView2.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/6.
//

import SwiftUI
import SwiftData

// 课程详情：显示关卡列表
struct CourseDetailView: View {
    @Bindable var viewModel: CourseViewModel
    @Binding var path: NavigationPath
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.session != nil {
                HStack {
                    Text(viewModel.course.title)
                        .font(.title)
                }
                
                List {
                    ForEach(viewModel.levels.indices, id: \.self) { index in
                        let level = viewModel.levels[index]
                        let completed = viewModel.levelsCompleted[level.id]
                        Button {
                            viewModel.session?.lastLevelIndex = index
                            path.append(level)
                        } label: {
                            Text("Level \(level.index). Completed: \(completed ?? false)")
                        }
                    }
                }
                
            } else if let error = viewModel.error {
                Text(error)
            }
        }
        .background(AppColors.background)
        .task {
            await viewModel.loadSession(context: modelContext)
        }
    }
}

#Preview {
    @Previewable @State var viewModel = CourseViewModel.mock(course: Course.all[0])
    @Previewable @State var path = NavigationPath()
    
    NavigationStack(path: $path) {
        CourseDetailView(
            viewModel: viewModel,
            path: $path
        )
            .modelContainer(for: [CourseSessionEntity.self], inMemory: true)
            .navigationDestination(for: ExerciseLevel.self) { level in
                LevelDetailView(
                    courseViewModel: viewModel,
                    path: $path
                )
            }
    }
}
