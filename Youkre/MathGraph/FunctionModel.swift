//
//  FunctionModel.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/18.
//

import SwiftUI

class FunctionModel: ObservableObject {
    @Published var f: (Double) -> Double
    @Published var df: (Double) -> Double
    @Published var a: Double
    @Published var b: Double
    @Published var currentX: Double
    @Published var isPlaying: Bool
    @Published var playbackSpeed: Double = 1.0
    
    let animationDuration: Double
    
    private var step: Double {
        (b - a) / (animationDuration * 60) * playbackSpeed // ~60 FPS
    }
    
    var showTangent: Bool {
        currentX > a && currentX < b
    }
    
    init(
        f: @escaping (Double) -> Double,
        df: @escaping (Double) -> Double,
        a: Double = -5,
        b: Double = 5,
        title: String = "",
        animationDuration: Double = 4.0
    ) {
        self.f = f
        self.df = df
        self.a = a
        self.b = b
        self.animationDuration = animationDuration
        self.currentX = a
        self.isPlaying = true
    }
    
    func reset() {
        currentX = a
        isPlaying = false
    }
    
    func setPlaying(_ shouldPlay: Bool) {
        if shouldPlay {
            if currentX >= b {
                reset()
            }
            isPlaying = true
        } else {
            isPlaying = false
        }
    }

    func togglePlay() {
        if currentX >= b { currentX = a }
        isPlaying.toggle()
    }
    
    func resetCurrentX() {
        currentX = a
    }
    
    func stopPlaying() {
        isPlaying = false
    }
    
    func tick() {
        guard isPlaying, currentX < b else {
            return
        }
        withAnimation(.linear(duration: 0.016)) {
            currentX += step
            // Turn isPlaying after auto-play finished.
            if currentX >= b {
                stopPlaying()
            }
        }
    }
}
