//
//  BotttomBar.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/13.
//

import SwiftUI

struct BottomBar: View {
    @ObservedObject var themeManager: ThemeManager
        
    var body: some View {
        VStack {
            HStack {
                // Theme toggler
                Button(action: {
                    themeManager.toggle()
                }) {
                    Image(
                        systemName: themeManager.isDark ? "sun.min" : "moon"
                    )
                    .padding()
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity)
        }
        .background(AppColors.contentBackground)
        .shadow(radius: 10)
    }
}
 

#Preview {
    @Previewable @StateObject var themeManager = ThemeManager.shared
    
    ZStack(alignment: .bottom) {
        Color.clear
        BottomBar(
            themeManager: ThemeManager.shared,
        )
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .environmentObject(themeManager)
        .preferredColorScheme(themeManager.preferredColorScheme)
    }
    
}
