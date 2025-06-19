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
                )
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


#endif
