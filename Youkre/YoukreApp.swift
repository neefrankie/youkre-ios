//
//  YoukreApp.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/3/8.
//

import SwiftUI

@main
struct YoukreApp: App {
    @StateObject private var themeManager = ThemeManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.preferredColorScheme)
                .background(AppColors.background)
        }
    }
}
