//
//  AboutDetailView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/16.
//

import SwiftUI

struct AboutDetailView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("youkre")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(16)
            
            Text(Config.appName)
                .font(.headline)
            
            Text("Version \(DeviceInfo.getAppVersion())")
                .font(.subheadline)
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    AboutDetailView()
}
