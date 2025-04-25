//
//  ThemePickerView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/14.
//

import SwiftUI

struct ThemePicker: View {
    
    @ObservedObject var themeManager: ThemeManager
    
    var body: some View {
        Picker(
            selection: $themeManager.selectedScheme,
            label: Text("深色模式")
        ) {
            
            ForEach(AppColorScheme.allCases) { scheme in
                Text(scheme.displayName)
                    .tag(scheme)
            }
        }
    }
}

#Preview {
    let themeManager = ThemeManager.shared.withDarkMode()
    
    ThemePicker(
        themeManager: themeManager
    )
        .pickerStyle(.segmented)
        .preferredColorScheme(themeManager.preferredColorScheme)
}

