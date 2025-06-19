//
//  BotttomBar.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/13.
//

import SwiftUI

struct BottomBar: View {
    @State private var isThemePickerVisible = false
    @ObservedObject var themeManager: ThemeManager
        
    var body: some View {
        VStack {
            // If theme toggle button is clicked, show the picker above the button
            if isThemePickerVisible {
                ThemePicker(
                    themeManager: themeManager
                )
                .padding(.top)
                .padding(.horizontal)
                .pickerStyle(.segmented)
            }
            
            HStack {
                
                Spacer()
                // Theme toggler
                Button(action: {
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
    @Previewable @StateObject var themeManager = ThemeManager.shared
    
    BottomBar(
        themeManager: ThemeManager.shared,
    )
    .transition(.move(edge: .bottom).combined(with: .opacity))
    .environmentObject(themeManager)
    .preferredColorScheme(themeManager.preferredColorScheme)
}
