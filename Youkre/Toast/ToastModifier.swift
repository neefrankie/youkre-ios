//
//  ToastModifier.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/9/15.
//

import SwiftUI

struct ToastModifier: ViewModifier {    
    func body(content: Content) -> some View {
        content
            .overlay {
                ToastView()
            }
    }
}

extension View {
    func toast() -> some View {
        modifier(ToastModifier())
    }
}
