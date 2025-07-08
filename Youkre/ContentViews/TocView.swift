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

struct TocCardView: View {
    let entry: TocDisplayEntry
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            symbolView(for: entry)
            
            VStack(alignment: .leading, spacing: 16) {
                Text(entry.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(entry.summary)
                    .font(.body)
                    .foregroundColor(.secondary)
                    
            }
            
            Spacer()
        }
        .modifier(PaddedCardStyle())
    }
    
    func symbolView(for entry: TocDisplayEntry) -> some View {
        if let sf = entry.icons.sfSymbol, !sf.isEmpty {
            return AnyView(
                IconBoxView(background: iconBackgroundColor(for: entry)) {
                    Image(systemName: sf)
                        .font(.system(size: 24))
                }
            )
        }
        
        if let key = entry.icons.predefined, let viewBuilder = IconStore.symbolViewMap[key] {
            return viewBuilder()
        }
        
        if let latex = entry.icons.latex, !latex.isEmpty {
            return AnyView(
                IconBoxView(background: .gray) {
                    LatexIconView(
                        latex: latex,
                    )
                }
            )
        }
        
        let letter = String(entry.title.prefix(1)).uppercased()
        return AnyView(
            IconBoxView(background: .secondary) {
                Text(letter)
                    .font(.system(size: 20, weight: .bold))
            }
        )
    }
    
    func iconBackgroundColor(for entry: TocDisplayEntry) -> Color {
        let palette: [Color] = [
            .blue, .green, .orange, .purple, .pink, .indigo, .teal, .cyan
        ]
        
        let index = abs(entry.slug.hashValue) % palette.count
        
        return palette[index].opacity(0.8)
    }
    
    
    
    func symbolName(for entry: TocDisplayEntry) -> String {
        let title = entry.slug.lowercased()
        if title.contains("function") {
            return "function"
        }
        if title.contains("integral") {
            return "sum"
        }
        if title.contains("limit") {
            return "arrow.right.to.line"
        }
        if title.contains("graph") {
            return "chart.xyaxis.line"
        }
        if title.contains("area") {
            return "square.split.diagonal.2x2"
        }
        if title.contains("product") {
            return "x.squareroot"
        }
        return "book"
    }
}

struct TocListView: View {
    var book: Book
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
                            value: ChapterParams(
                                book: book,
                                current: entry
                            )
                        ) {
                            TocCardView(entry: entry)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding()
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
            } else if let entries = viewModel.tocEntries {
                TocListView(
                    book: book,
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
    }
}

#Preview {
    @Previewable @StateObject var themeManager = ThemeManager.shared
    
    TocView(book: DataStore.bookList[1])
        .environmentObject(themeManager)
        .preferredColorScheme(themeManager.preferredColorScheme)
        .background(AppColors.background)
}
