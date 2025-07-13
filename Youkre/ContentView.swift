//
//  ContentView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/3/8.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @AppStorage("hasComplatedOnBoarding") var hasCompletedOnboarding = false
    var body: some View {
        if !hasCompletedOnboarding {
            OnboardingView(
                hasCompletedOnBoarding: $hasCompletedOnboarding
            )
                .onDisappear {
                    hasCompletedOnboarding = true
                }
        } else {
            MainView()
        }
    }
}

#Preview {
    @Previewable @StateObject var settings = ThemeManager.shared
    
    ContentView()
        .environmentObject(settings)
        .preferredColorScheme(settings.preferredColorScheme)
}
