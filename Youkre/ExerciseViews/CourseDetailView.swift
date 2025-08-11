//
//  ExerciseSwipingView2.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/6.
//

import SwiftUI
import SwiftData

@MainActor
class ExerciseLevelViewModel: ObservableObject {
    let course: Course
    let session: CourseSession
    let level: ExerciseLevel
    
    @Published var isLoading = true
    @Published var error: String? = nil
    @Published var levelProgress: LevelProgress?
    @Published var exerciseStates: [ExerciseState] = []
    @Published var currentIndex: Int = 0
    
    init(course: Course, session: CourseSession, level: ExerciseLevel) {
        self.course = course
        self.session = session
        self.level = level
    }
    
    var progressText: String {
        "\(currentIndex + 1) / \(exerciseStates.count)"
    }
    
    func createExerciseProgress(
        for exercise: ExerciseV2,
        context: ModelContext
    ) async -> ExerciseProgress {
        do {
            let exerciseProgress = try await SessionDataSource.shared
                .loadOrCreateExerciseProgerss(
                    levelProgress: levelProgress!,
                    exercise: exercise,
                    context: context,
                )
            
            return exerciseProgress
        } catch {
            print(error)
        }
        
        let fallback = ExerciseProgress.new(exerciseID: exercise.id)
        return fallback
    }
    
    func loadLevelProgress(context: ModelContext) async {
        isLoading = true
        
        do {
            let exercises = await ExerciseDataSource.shared.loadExercises(
                for: course,
                level: level
            )
            
            var levelProgress = try await SessionDataSource.shared.loadOrCreateLevelProgress(
                session: session,
                level: level,
                context: context
            )
            
            let currentProgress = Dictionary(
                uniqueKeysWithValues: levelProgress.exerciseProgress.map{
                    (key: $0.exerciseID, value: $0)
                }
            )
            
            levelProgress.exerciseProgress = []
            
            var states: [ExerciseState] = []
            for exercise in exercises {
                if let progress = currentProgress[exercise.id] {
                    states.append(ExerciseState(
                        exercise: exercise,
                        progress: progress
                    ))
                } else {
                    let progress = await createExerciseProgress(for: exercise, context: context)
                    states.append(ExerciseState(
                        exercise: exercise,
                        progress: progress
                    ))
                }
            }
            
            self.exerciseStates = states
            self.levelProgress = levelProgress
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}

struct CourseDetailView: View {
    @StateObject var viewModel: ExerciseLevelViewModel
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.levelProgress != nil {
                VStack {
                    HStack {
                        Text("\(viewModel.progressText)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    TabView(selection: $viewModel.currentIndex) {
                        ForEach(viewModel.exerciseStates.indices, id: \.self) { index in
                            MultipleChoiceView(
                                exercise: viewModel.exerciseStates[index].exercise,
                                currentState: $viewModel.exerciseStates[index].progress
                            )
                            .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .indexViewStyle(.page(backgroundDisplayMode: .never))
                }
            } else if let error = viewModel.error {
                Text(error)
            }
        }
        .task {
            await viewModel.loadLevelProgress(context: modelContext)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try? ModelContainer(
            for: CourseSessionEntity.self,
            configurations: config
        )
        
        let course = Course.all[0]
        let courseSession = CourseSessionEntity(course: course)
        
        if let context = container?.mainContext {
            context.insert(courseSession)
        }
        
        return CourseDetailView(
            viewModel: ExerciseLevelViewModel(
                course: Course.all[0],
                session: courseSession.toModel(),
                level: ExerciseDataV2.cme[0]
            )
        )
//        .modelContainer(container!)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
    
}
