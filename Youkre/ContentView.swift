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
    var settings = ThemeManager.shared.withLightMode()
    
    ContentView()
        .environmentObject(settings)
        .preferredColorScheme(settings.preferredColorScheme)
}
