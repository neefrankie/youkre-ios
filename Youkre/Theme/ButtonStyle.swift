//
//  ButtonStyle.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/18.
//

import SwiftUI

struct ColoredCircleButtonStyle: ButtonStyle {
    var backgroundColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(backgroundColor)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct CapsuleButtonStyle: ButtonStyle {
    var backgroundColor: Color = .cyan
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(
                Capsule()
                    .fill(backgroundColor)
            )
            .foregroundStyle(.white)
    }
}

struct CapsuleBorderButtonStyle: ButtonStyle {
    var strokeColor: Color = Color.gray
    var backgroundColor: Color = .clear
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                Capsule()
                    .stroke(strokeColor)
                    .background(Capsule().fill(backgroundColor))
            )
            .foregroundStyle(strokeColor)
    }
}

struct ProminentButtonStyle: ButtonStyle {
    var backgroundColor: Color = .teal
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(backgroundColor)
            )
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .shadow(
                color: .black.opacity(0.2),
                radius: configuration.isPressed ? 1 : 4,
                x: 0,
                y: 2
            )
            .animation(
                .easeOut(duration: 0.15),
                value: configuration.isPressed
            )
    }
}


#Preview {
    VStack(spacing: 20) {
        Button("", systemImage: "play.fill") {
            
        }
        .labelStyle(.iconOnly)
        .buttonStyle(.borderedProminent)
        
        // Play button
        Button("", systemImage: "pause.fill") {
            
        }
        .labelStyle(.iconOnly)
        .buttonStyle(ProminentButtonStyle(backgroundColor: .teal))
        
        Button("", systemImage: "arrow.counterclockwise") {
            
        }
        .buttonStyle(ColoredCircleButtonStyle(backgroundColor: .brown))
        
        Button {
            
        } label: {
            Text("完成")
        }
        .buttonStyle(CapsuleButtonStyle())
        
        Button("微积分") {
            
        }
        .buttonStyle(CapsuleBorderButtonStyle(backgroundColor: .green))
    }
}
