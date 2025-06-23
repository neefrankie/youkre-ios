//
//  PlaybackControlView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/18.
//

import SwiftUI

struct PlaybackControlView: View {
    @ObservedObject var model: FunctionModel
    
    var body: some View {
        
        VStack {
            HStack(spacing: 20) {
                // Play button
                Button{
                    model.togglePlay()
                } label: {
                    Label(
                        model.isPlaying ? "Pause" : "Play",
                        systemImage: model.isPlaying ? "pause.fill" : "play.fill"
                    )
                    .labelStyle(.iconOnly)
                }
                .buttonStyle(ProminentButtonStyle(backgroundColor: .teal))
                
                
                // Reset button
                Button{
                    model.reset()
                } label: {
                    Label(
                        "Reset",
                        systemImage: "arrow.counterclockwise"
                    )
                    .labelStyle(.iconOnly)
                }
                .foregroundColor(.teal)
            }
            
            HStack{
                Text("速度: \(String(format: "%.1fx", model.playbackSpeed))")
                    .font(.caption)
                    .foregroundColor(Color(UIColor.secondaryLabel))
                Slider(
                    value: $model.playbackSpeed,
                    in: 0.1...3.0,
                    step: 0.1
                )
                .accentColor(.teal)
            }
        }
        
    }
}

#Preview {
    PlaybackControlView(model: FunctionModel())
}
