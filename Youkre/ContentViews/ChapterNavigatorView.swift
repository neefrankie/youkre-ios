//
//  ChapterNavigatorView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/14.
//

import SwiftUI

enum ChapterDirection {
    case previous
    case next
}

struct SegmentedButton: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var label: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.caption)
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
                .background(
                    colorScheme == .light
                    ? Color.white
                    : Color(UIColor.systemGray).opacity(0.8)
                )
                .foregroundColor(Color.primary)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 8,
                        style: .continuous
                    )
                )
        }
        .buttonStyle(.plain)
//        .overlay(
//            RoundedRectangle(
//                cornerRadius: 8,
//                style: .continuous
//            )
//                .stroke(
//                    Color(UIColor.systemGray3),
//                    lineWidth: 1
//                )
//        )
    }
}

struct ChapterNavigatorView: View {
    var hasPrevious: Bool
    var hasNext: Bool
    
    var onChapterNavigate: (_ direction: ChapterDirection) -> Void
    
    var body: some View {
        HStack {
            Spacer()
            
            SegmentedButton(
                label: "上一章"
            ) {
                onChapterNavigate(.previous)
            }
            .disabled(!hasPrevious)
            
            Spacer()
            
            SegmentedButton(
                label: "下一章"
            ) {
                onChapterNavigate(.next)
            }
            .disabled(!hasNext)
            
            Spacer()
        }
    }
}


#Preview {    
    ChapterNavigatorView(
        hasPrevious: false,
        hasNext: true,
        onChapterNavigate: { direction in
            print(direction)
        }
    )
    .background(.ultraThinMaterial)
    .preferredColorScheme(.light)
}
