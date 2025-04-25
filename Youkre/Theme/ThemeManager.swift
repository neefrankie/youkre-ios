//
//  ThemeManager.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/11.
//

import SwiftUI

enum AppColorScheme: String, CaseIterable, Identifiable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
    
    var id: String {
        self.rawValue
    }
    
    var displayName: String {
        switch self {
        case .system:
            return "跟随系统"
        case .light:
            return "浅色模式"
        case .dark:
            return "深色模式"
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        default:
            return nil
        }
    }
}


class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    private let schemeKey = "selectedColorScheme"
    
    @Published
    var selectedScheme: AppColorScheme {
        didSet {
            UserDefaults.standard.set(selectedScheme.rawValue, forKey: schemeKey)
        }
    }
    
    var preferredColorScheme: ColorScheme? {
        selectedScheme.colorScheme
    }
    
    private init() {
        let rawValue = UserDefaults.standard.string(forKey: schemeKey)
        selectedScheme = AppColorScheme(rawValue: rawValue ?? "") ?? .system
    }
    
    var resolvedTheme: String {
        switch selectedScheme {
        case .system:
            if #available(iOS 13.0, *) {
                return UITraitCollection.current.userInterfaceStyle == .dark ? "dark" : "light"
            } else {
                return "light"
            }
            
        case .light:
            return "light"
        case .dark:
            return "dark"
        }
    }
    
    var jsThemeScript: String {
        return "document.documentElement.setAttribute('data-bs-theme', '\(resolvedTheme)')"
    }
    
    func withDarkMode() -> ThemeManager {
        self.selectedScheme = .dark
        return self
    }
    
    func withLightMode() -> ThemeManager {
        self.selectedScheme = .light
        return self
    }
    
    
    
}
