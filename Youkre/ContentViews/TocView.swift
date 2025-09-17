//
//  TOCView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/3/13.
//

import SwiftUI
import Combine



struct TocView: View {
    @State private var isLoading = true
    @State private var hasLoaded = false
    @State private var error: String? = nil
    @State private var tocEntries: [TocDisplayEntry]?
    
    let course: Course

    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else if let entries = tocEntries {
                TocListView(
                    course: course,
                    entries: entries,
                )
            } else if let error {
                Text(error)
            }
        }
        .navigationTitle(course.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .task {
            await loadData()
        }
        .background(AppColors.background)
    }
    
    @MainActor
    func loadData() async {
        guard !hasLoaded else {
            return
        }
        // Cleared previous error state at the start of the function
        self.isLoading = true
        self.error = nil
        
        do {
            let tocEntries = try await ExerciseDataSource.shared.findTocList(for: course)
            self.tocEntries = TableOfContents.flattenToc(tocEntries)
            self.error = nil
            self.hasLoaded = true  // ✅ Set only on success
        } catch {
            print(error)
            self.error = error.localizedDescription
        }
        
        self.isLoading = false
    }
}

#Preview {
    @Previewable @StateObject var themeManager = ThemeManager.shared
    
    NavigationStack {
        TocView(course: ExampleData.courses[0])
    }
//    To preview, place theme manager here rather than TocView.
    .environmentObject(themeManager)
    .preferredColorScheme(themeManager.preferredColorScheme)
    
}
