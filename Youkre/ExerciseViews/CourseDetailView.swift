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
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.session != nil {
                VStack(alignment: .leading, spacing: 24) {
                    Text(viewModel.course.title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LazyVGrid(columns: layout, spacing: 16) {
                        ForEach(viewModel.levels.indices, id: \.self) { index in
                            let level = viewModel.levels[index]
                            let completed = viewModel.levelsCompleted[level.id] ?? false
                            
                            LevelCardView(
                                index: index,
                                level: level,
                                isCompleted: completed,
                                isLocked: false,
                            ) {
                                viewModel.changeLevel(index: index)
                                path.append(level)
                            }
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
            } else if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .toolbar(.hidden, for: .tabBar)
        .background(AppColors.background)
        .onAppear {
            viewModel.loadSession()
        }
    }
}

#Preview {
    @Previewable @State var viewModel = CourseViewModel(course: ExampleData.courses[0])
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
