//
//  FunctionModel.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/18.
//

import SwiftUI

class FunctionModel: ObservableObject {
    let bounds: (Double, Double)
    
    @Published var currentX: Double
    @Published var isPlaying: Bool
    @Published var playbackSpeed: Double = 1.0
    
    let animationDuration: Double
    
    private var step: Double {
        (bounds.1 - bounds.0) / (animationDuration * 60) * playbackSpeed // ~60 FPS
    }
    
    init(
        bounds: (Double, Double) = (-5, 5),
        animationDuration: Double = 4.0
    ) {
        self.bounds = bounds
        self.animationDuration = animationDuration
        self.currentX = bounds.0
        self.isPlaying = true
    }
    
    func reset() {
        currentX = bounds.0
        isPlaying = false
    }
    
    func setPlaying(_ shouldPlay: Bool) {
        if shouldPlay {
            if currentX >= bounds.1 {
                reset()
            }
            isPlaying = true
        } else {
            isPlaying = false
        }
    }

    func togglePlay() {
        if currentX >= bounds.1 { currentX = bounds.0 }
        
        isPlaying.toggle()
    }
    
    func resetCurrentX() {
        currentX = bounds.0
    }
    
    func stopPlaying() {
        isPlaying = false
    }
    
    func tick() {
        guard isPlaying, currentX < bounds.1 else {
            return
        }
        withAnimation(.linear(duration: 0.016)) {
            currentX += step
            // Turn isPlaying after auto-play finished.
            if currentX >= bounds.1 {
                stopPlaying()
            }
        }
    }
}
