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
            
            MeView()
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
    ContentView()
}
