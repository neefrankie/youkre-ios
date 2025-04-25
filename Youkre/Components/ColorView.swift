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
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80))
    ]
    
    var body: some View {
        ScrollView {
            ThemePicker(themeManager: themeManager)
                .pickerStyle(.segmented)
            
            LazyVGrid(columns: layout) {
                
                Text("System Gray")
                    .padding()
                    .background(Color(UIColor.systemGray))
                
                Text("System Gray 2")
                    .padding()
                    .background(Color(UIColor.systemGray2))
                
                Text("System Gray 3")
                    .padding()
                    .background(Color(UIColor.systemGray3))
                
                Text("System Gray 4")
                    .padding()
                    .background(Color(UIColor.systemGray4))
                
                Text("Secondary Label")
                    .padding()
                    .background(Color(UIColor.secondaryLabel))
            }
        }
        .preferredColorScheme(themeManager.preferredColorScheme)
    }
}

#Preview {
    let themeManager = ThemeManager.shared.withDarkMode()
    
    ColorView(themeManager: themeManager)
        .preferredColorScheme(themeManager.preferredColorScheme)
}
