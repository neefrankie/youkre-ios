//
//  Modifiers.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/19.
//

import SwiftUI

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(AppColors.contentBackground)
            .cornerRadius(12)
            .shadow(
                color: .black.opacity(0.05),
                radius: 2,
                x: 0,
                y: 1
            )
    }
}
