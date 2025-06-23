//
//  TOCView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/3/13.
//

import SwiftUI
import Combine

class TocViewModel: ObservableObject {
    @Published var tocItems: [TocEntry]?
    @Published var isLoading: Bool = true
    @Published var error: String? = nil
    private var hasLoaded = false
    private var bookSlug: String
    
    init(bookSlug: String) {
        self.bookSlug = bookSlug
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
        
        let result = await Bundle.main.decodeToc(of: bookSlug)
        
        await MainActor.run {
            switch result {
            case .success(let decodedToc):
                self.tocItems = decodedToc.items
                self.error = nil
                self.hasLoaded = true  // ✅ Set only on success
                
            case .failure(let error):
                self.tocItems = nil
                self.error = error.errorDescription ?? error.localizedDescription
            }
            
            self.isLoading = false
        }
    }
}

struct TocListView: View {
    var book: Book
    var tocItems: [TocEntry]
    
    var body: some View {
        List {
            ForEach(tocItems) { entry in
                if entry.slug.isEmpty {
                    Text(entry.text)
                } else {
                    NavigationLink(
                        entry.text,
                        value: ChapterParams(
                            book: book,
                            current: entry
                        )
                    )
                }
            }
        }
        .navigationDestination(
            for: ChapterParams.self
        ) { params in
            ChapterView(params: params)
        }
    }
}

struct TocView: View {
    private let book: Book
    @StateObject private var viewModel: TocViewModel
    
    init(book: Book) {
        self.book = book
        _viewModel = StateObject(
            wrappedValue: TocViewModel(bookSlug: book.slug)
        )
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let items = viewModel.tocItems {
                TocListView(
                    book: book,
                    tocItems: items,
                )
            } else if let error = viewModel.error {
                Text(error)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .task {
            await viewModel.loadData()
        }
    }
}

#Preview {
    TocView(book: Book(
        id: "calculus-made-easy",
        slug: "calculus-made-easy",
        title: "简易微积分",
        cover: "calculus-made-easy.webp",
        body: [""]
    ))
}
