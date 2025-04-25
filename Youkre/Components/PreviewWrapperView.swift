//
//  PreviewWrapperView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/15.
//

import SwiftUI

#if DEBUG
struct PreviewWrapperView<Content: View>: View {
    @StateObject private var themeManager = ThemeManager.shared
    let content: () -> Content

    var body: some View {
        content()
            .environmentObject(themeManager)
            .preferredColorScheme(themeManager.preferredColorScheme)
    }
}
#endif
