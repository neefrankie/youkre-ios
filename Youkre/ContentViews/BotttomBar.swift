//
//  BotttomBar.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/13.
//

import SwiftUI

struct BottomBar: View {
    @State private var isThemePickerVisible = false
    @State private var isChapterVisible = false
    @ObservedObject var themeManager: ThemeManager
    
    var hasPreviousChapter: Bool
    var hasNextChapter: Bool
    
    var onChapterNavigate: (_ direction: ChapterDirection) -> Void
    var onPresentToc: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            if isThemePickerVisible {
                ThemePicker(
                    themeManager: themeManager
                )
                .padding(.top)
                .padding(.horizontal)
                .pickerStyle(.segmented)
            }
            
            if isChapterVisible {
                ChapterNavigatorView(
                    hasPrevious: hasPreviousChapter,
                    hasNext: hasNextChapter,
                    onChapterNavigate: onChapterNavigate
                )
                .padding(.top)
            }
            
            HStack {
                if onPresentToc != nil {
                    Button(action: {
                        onPresentToc?()
                    }) {
                        Image(
                            systemName: "list.bullet"
                        )
                        .padding()
                    }
                    .buttonStyle(.plain)
                }
                
                
                Spacer()
                
                // Chapter navigator toggler
                if hasPreviousChapter || hasNextChapter {
                    Button(action: {
                        isThemePickerVisible = false
                        isChapterVisible.toggle()
                    }) {
                        Image(
                            systemName: "books.vertical"
                        )
                            .padding()
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                }
                
                // Theme toggler
                Button(action: {
                    isChapterVisible = false
                    isThemePickerVisible.toggle()
                }) {
                    Image(
                        systemName: "circle.lefthalf.filled"
                    )
                        .padding()
                }
                .buttonStyle(.plain)
                
                Spacer()
            }
        }
//        .background(.ultraThinMaterial)
        .background(Color(UIColor.systemBackground))
        .shadow(radius: 10)
    }
}
 

#Preview {
    
    BottomBar(
        themeManager: ThemeManager.shared,
        hasPreviousChapter: true,
        hasNextChapter: true,
    ) { direction in
        print("Clicked \(direction)")
    }
    .transition(.move(edge: .bottom).combined(with: .opacity))
}
