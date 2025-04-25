//
//  TOCView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/3/13.
//

import SwiftUI
import Combine

class TOCViewModel: ObservableObject {
    @Published var tocItems: [TocEntry]?
    @Published var isLoading: Bool = true
    @Published var error: String? = nil
    
    func loadData(slug: String) async {
        await MainActor.run {
            self.isLoading = true
        }
        
        let result = await Bundle.main.decodeToc(of: slug)
        
        switch result {
        case .success(let decodedToc):
            await MainActor.run {
                self.tocItems = Array(decodedToc.items[0...4])
                self.tocItems?.append(
                    TocEntry(
                        id: "",
                        slug: "",
                        text: "未完待续...",
                        title: "",
                        subtitle: ""
                    )
                )
                self.isLoading = false
            }
        case .failure(let error):
            if let errorMessage = error.errorDescription {
                await MainActor.run {
                    self.error = errorMessage
                    self.isLoading = false
                }
            } else {
                await MainActor.run {
                    self.error = "\(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }
    }
}

struct TOCView: View {
    var book: Book

    @StateObject private var viewModel = TOCViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let items = viewModel.tocItems {
                List {
                    ForEach(
                        Array(items.enumerated()),
                        id: \.element
                    ) { index, entry in
                        if entry.slug.isEmpty {
                            Text(entry.text)
                        } else {
                            NavigationLink(
                                entry.text,
                                value: ChapterParams(
                                    book: book,
                                    toc: items,
                                    currentIndex: index,
                                    currentEntry: entry
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
                .navigationTitle(book.title)
            } else {
                Text("Error")
            }

        }
        .toolbar(.hidden, for: .tabBar)
        .task {
            await viewModel.loadData(slug: book.slug)
        }
    }
}

#Preview {
    TOCView(book: Book(
        id: "calculus-made-easy",
        slug: "calculus-made-easy",
        title: "简易微积分",
        cover: "calculus-made-easy.webp",
        body: [""]
    ))
}
