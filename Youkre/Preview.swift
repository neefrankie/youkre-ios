//
//  PreviewWrapperView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/15.
//

#if DEBUG

import SwiftUI

struct PreviewWrapperView<Content: View>: View {
    @StateObject private var themeManager = ThemeManager.shared
    let content: () -> Content

    var body: some View {
        content()
            .environmentObject(themeManager)
            .preferredColorScheme(themeManager.preferredColorScheme)
    }
}

struct PreviewBottomBar: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var isBottomBarVisible = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.red // Your background or main content
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        isBottomBarVisible.toggle()
                    }
                }

            if isBottomBarVisible {
                BottomBar(
                    themeManager: themeManager,
                    hasPreviousChapter: true,
                    hasNextChapter: true,
                ) { direction in
                    print("Clicked \(direction)")
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}

#Preview {
    PreviewWrapperView {
        PreviewBottomBar()
    }
}

#Preview {
    PreviewWrapperView {
        HomeView()
    }
}

#Preview {
    PreviewWrapperView {
        SettingsView()
    }
}

#Preview {
    let toc = [
        TocEntry(
            id: "ace1f71919520c90",
            slug: "prologue",
            text: "前言",
            title: "",
            subtitle: ""
        ),
        TocEntry(
            id: "662caa141e1055c3",
            slug: "1",
            text: "第 1 章 摆脱恐惧",
            title: "",
            subtitle: ""
        ),
        TocEntry(
            id: "69b61e849f4eaca5",
            slug: "2",
            text: "第 2 章 不同程度的微小性",
            title: "",
            subtitle: ""
        )
    ]
    
    PreviewWrapperView {
        ChapterView(
            params: ChapterParams(
                book: DataStore.bookList[0],
                toc: toc,
                currentIndex: 1,
                currentEntry: toc[1]
            )
        )
    }
}

#endif
