//
//  ToastMessage.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/9/15.
//

import Foundation

struct ToastMessage: Identifiable {
    let id = UUID()
    let text: String
    let duration: TimeInterval
}
