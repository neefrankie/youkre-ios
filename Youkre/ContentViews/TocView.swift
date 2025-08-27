//
//  TOCView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/3/13.
//

import SwiftUI
import Combine

class TocViewModel: ObservableObject {
    @Published var tocEntries: [TocDisplayEntry]?
    @Published var isLoading: Bool = true
    @Published var error: String? = nil
    private var hasLoaded = false
    private var courseSlug: String
    
    init(courseSlug: String) {
        self.courseSlug = courseSlug
    }
    
    func loadData() async {
        guard !hasLoaded else {
            return
        }
        // Cleared previous error state at the start of the function
        await MainActor.run {
            self.isLoading = true
            self.error = nil
        }
        
        let result = await Bundle.main.decodeToc(of: courseSlug)
        
        await MainActor.run {
            switch result {
            case .success(let decodedToc):
                self.tocEntries = decodedToc.flattenItems()
                self.error = nil
                self.hasLoaded = true  // ✅ Set only on success
                
            case .failure(let error):
                self.tocEntries = nil
                self.error = error.errorDescription ?? error.localizedDescription
            }
            
            self.isLoading = false
        }
    }
}

struct TocListView: View {
    var course: Book
    var entries: [TocDisplayEntry]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(entries) { entry in
                    if entry.slug.isEmpty {
                        Text(entry.title)
                            .font(.title)
                            .padding(.top, 32)
                    } else {
                        NavigationLink(
                            value: ChapterLink(
                                courseSlug: course.slug,
                                chapterSlug: entry.slug,
                            )
                        ) {
                            TextCardView(
                                title: entry.title,
                                summary: entry.summary
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding()
        }
        
    }
}

struct TocView: View {
    private let course: Book
    @StateObject private var viewModel: TocViewModel
    
    init(course: Book) {
        self.course = course
        _viewModel = StateObject(
            wrappedValue: TocViewModel(courseSlug: course.slug)
        )
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let entries = viewModel.tocEntries {
                TocListView(
                    course: course,
                    entries: entries,
                )
            } else if let error = viewModel.error {
                Text(error)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .task {
            await viewModel.loadData()
        }
        .background(AppColors.background)
    }
}

#Preview {
    @Previewable @StateObject var themeManager = ThemeManager.shared
    
    NavigationStack {
        TocView(course: Book.bookList[1])
    }
//    To preview, place theme manager here rather than TocView.
    .environmentObject(themeManager)
    .preferredColorScheme(themeManager.preferredColorScheme)
    
}
