//
//  Modifiers.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/19.
//

import SwiftUI

struct PaddedCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(AppColors.contentBackground)
            .cornerRadius(12)
            .shadow(radius: 2)
    }
}

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(AppColors.contentBackground)
            .cornerRadius(12)
            .shadow(radius: 2)
            
    }
}

struct TitleStyle: ViewModifier {
    let level: Int
    
    private var font: Font? {
        switch level {
        case 1:
            return Font.title
        case 2:
            return Font.title2
        case 3:
            return Font.title3
        default:
            return nil
        }
    }
    
    func body(content: Content) -> some View {
        content.font(font)
            .bold()
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    VStack {
        Text("hello")
            .frame(maxWidth: .infinity)
            .modifier(PaddedCardStyle())
    }
    .padding()
    .background(AppColors.background)
}
