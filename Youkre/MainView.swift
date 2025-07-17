//
//  MainView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/12.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ExerciseSwipeView()
                .tabItem {
                    Label(
                        "练习",
                        systemImage: "graduationcap"
                    )
                }
                .background(AppColors.background)
            BookListView()
                .tabItem {
                    Label(
                        "学习",
                        systemImage: "book"
                    )
                }
                .background(AppColors.background)
            
            FunctionPagerView()
                .tabItem {
                    Label(
                        "图示",
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
    
    MainView()
        .environmentObject(settings)
        .preferredColorScheme(settings.preferredColorScheme)
}
