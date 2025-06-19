//
//  ColorView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/14.
//

import SwiftUI

struct ColorView: View {
    @StateObject var themeManager: ThemeManager
    
    let layout = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    
    let colors: [(String, UIColor)] = [
        ("System Red", UIColor.systemRed),
        ("System Green", UIColor.systemGreen),
        ("System Orange", UIColor.systemOrange),
        ("System Teal", UIColor.systemTeal),
        ("System Indigo", UIColor.systemIndigo),
        ("System Cyan", UIColor.systemCyan),
        ("System Gray", UIColor.systemGray),
        ("System Gray2", UIColor.systemGray2),
        ("System Gray3", UIColor.systemGray3),
        ("System Gray4", UIColor.systemGray4),
        ("System Gray5", UIColor.systemGray5),
        ("System Gray6", UIColor.systemGray6),
        ("Label", UIColor.label),
        ("Secondary Label", UIColor.secondaryLabel)
    ]
    
    var body: some View {
        ScrollView {
            ThemePicker(themeManager: themeManager)
                .pickerStyle(.segmented)
            
            LazyVGrid(columns: layout, spacing: 10) {
                ForEach(colors, id: \.0) { item in
                    Text(item.0)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(item.1))
                        .cornerRadius(10)
                }
            }
        }
        .preferredColorScheme(themeManager.preferredColorScheme)
    }
}

#Preview {
    @Previewable @StateObject var themeManager = ThemeManager.shared.withDarkMode()
    
    ColorView(themeManager: themeManager)
        .preferredColorScheme(themeManager.preferredColorScheme)
}
