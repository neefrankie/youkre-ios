//
//  ContentView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/3/8.
//

import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(
                        Config.appName,
                        systemImage: "book"
                    )
                }
                .background(AppColors.background)
            
            FunctionPagerView()
                .tabItem {
                    Label(
                        "图式",
                        systemImage: "function"
                    )
                }
                .background(AppColors.background)
            
            SettingsView()
                .tabItem {
                    Label(
                        "我的",
                        systemImage: "person"
                    )
                }
        }
    }
}

#Preview {
    @Previewable @StateObject var settings = ThemeManager.shared
    
    ContentView()
        .environmentObject(settings)
        .preferredColorScheme(settings.preferredColorScheme)
}
