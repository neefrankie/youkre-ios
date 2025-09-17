//
//  ToastView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/9/15.
//

import SwiftUI

struct ToastView: View {
    @ObservedObject var manager = ToastManager.shared
    
    var body: some View {
        if let toast = manager.toast {
            ZStack {
                HStack {
                    Text(toast.text)
                        .padding(32)
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .font(.caption)
                        .cornerRadius(8)
                }
                .transition(.move(edge: .bottom))
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    VStack {
        Button("Show Toast") {
            ToastManager.shared.show(text: "Saved")
        }
    }
    .toast()
}
