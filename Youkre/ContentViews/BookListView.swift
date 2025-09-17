//
//  HomeView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/3/16.
//

import SwiftUI

struct BookListView: View {
    @State private var isLoading = true
    @State private var error: String? = nil
    @State private var courses: [Course]? = nil
    
    var body: some View {
        NavigationStack {
            if isLoading {
                ProgressView()
            } else if let courses {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(courses) { course in
                            NavigationLink(value: course) {
                                bookCard(course: course)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
                .navigationDestination(for: Course.self) { course in
                    TocView(course: course)
                }
                .navigationDestination(for: ChapterLink.self) { params in
                    ChapterView(params: params)
                }
                .navigationBarTitleDisplayMode(.inline)
            } else if let error {
                Text(error)
            }
        }
        .background(AppColors.background)
        .task {
            await loadCourses()
        }
    }
    
    @MainActor
    private func loadCourses() async {
        isLoading = true
        
        do {
            let courses = try await ExerciseDataSource.shared.loadCourse()
            self.courses = courses
        } catch {
            print(error)
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    func bookCard(course: Course) -> some View {
        HStack(alignment: .center, spacing: 16) {
            if let icon = course.icons {
                SymbolView(
                    icon: icon,
                    backgroundColor: iconBackgroundColor(for: course)
                )
            }
            
            
            VStack(alignment: .leading, spacing: 16) {
                Text(course.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if let summary = course.summary {
                    Text(summary)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .modifier(PaddedCardStyle())
    }
    
    func iconBackgroundColor(for course: Course) -> Color {
        let palette: [Color] = [
            .blue, .green, .orange, .purple, .pink, .indigo, .teal, .cyan
        ]
        
        let index = abs(course.slug.hashValue) % palette.count
        
        return palette[index].opacity(0.8)
    }
}


#Preview {
    @Previewable @StateObject var themeManager = ThemeManager.shared
    
    BookListView()
        .environmentObject(themeManager)
        .preferredColorScheme(themeManager.preferredColorScheme)
}
