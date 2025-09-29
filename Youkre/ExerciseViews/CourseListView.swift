//
//  CourseLauncherView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/6.
//

import SwiftUI

struct CourseListView: View {
    @State private var isLoading = true
    @State private var error: String? = nil
    @State private var courses: [Course]? = nil
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else if let courses {
                Text("更多练习")
                    .padding(.top, 32)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVGrid(columns: layout, spacing: 16) {
                    ForEach(courses) { course in
                        NavigationLink(value: course) {
                            FigureCardView(
                                title: course.title,
                                imageName: course.slug,
                                fit: true,
                                ratio: 1,
                            )
                        }
                    }
                }
            } else if let error {
                Text(error)
            }
        }
        .onAppear {
            loadCourses()
        }
        
    }
    
    private func loadCourses() {
        isLoading = true
        
        Task(priority: .background) {
            do {
                let courses = try await ExerciseDataSource.shared.loadCourse()
                
                await MainActor.run {
                    self.courses = courses
                    isLoading = false
                }
                
            } catch {
                print(error)
                await MainActor.run {
                    self.error = error.localizedDescription
                    isLoading = false
                }
                
            }
            
        }
    }
}



#Preview {
    CourseListView()
        .padding()
}
