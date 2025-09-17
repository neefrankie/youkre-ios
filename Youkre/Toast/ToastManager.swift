//
//  ToastManager.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/9/15.
//

import SwiftUI

class ToastManager: ObservableObject {
    @Published var toast: ToastMessage?
    
    static let shared = ToastManager()
    
    private init() {}
    
    func show(text: String, duration: TimeInterval = 2) {
        toast = ToastMessage(text: text, duration: duration)
        
//        Task {
//            let nanoseconds = UInt64(duration * 1_000_000_000)
//            try? await Task.sleep(nanoseconds: nanoseconds)
//            self.toast = nil
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.toast = nil
        }
    }
}
