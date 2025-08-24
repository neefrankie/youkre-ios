//
//  LevelCard.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/20.
//

import SwiftUI

struct LevelCardView: View {
    let index: Int
    let level: ExerciseLevel
    let isCompleted: Bool
    let isLocked: Bool
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(backgroundColor)
                    .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
                
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(badgeColor)
                            .frame(width: 40, height: 40)
                        
                        Image(systemName: badgeIcon)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                        
                        if !isCompleted && !isLocked {
                            Text("\(index + 1)")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .bold))
                        }
                    }
                    
                    Text("第\(index + 1)关")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(textColor)
                        .lineLimit(1)
                }
                .padding()
            }
            .frame(height: 100)
            .opacity(isLocked ? 0.6 : 1.0)
        }
        .disabled(isLocked)
        .buttonStyle(.plain)
    }
    
    private var backgroundColor: Color {
        if isLocked {
            return Color(uiColor: .systemGray5)
        } else {
            return Color(uiColor: .systemBackground)
        }
    }
    
    private var badgeColor: Color {
        if isLocked {
            return Color.gray
        } else if isCompleted {
            return Color.green
        } else {
            return Color.cyan
        }
    }
    
    private var badgeIcon: String {
        if isLocked {
            return "lock"
        } else if isCompleted {
            return "checkmark"
        } else {
            return "number"
        }
    }
    
    private var textColor: Color {
        if isLocked {
            return .secondary
        } else {
            return .primary
        }
    }
}

#Preview {
    LevelCardView(
        index: 0,
        level: ExerciseLevel(
            id: "id",
            courseID: "course-id",
            courseSlug: "course-slug",
            chapterID: "article-id",
            chapterSlug: "article-slug",
            title: "Preview",
            index: 0
        ),
        isCompleted: true,
        isLocked: false,
        action: { }
    )
    
    LevelCardView(
        index: 1,
        level: ExerciseLevel(
            id: "id",
            courseID: "course-id",
            courseSlug: "course-slug",
            chapterID: "article-id",
            chapterSlug: "article-slug",
            title: "Preview",
            index: 0
        ),
        isCompleted: false,
        isLocked: false,
        action: { }
    )
    
    LevelCardView(
        index: 2,
        level: ExerciseLevel(
            id: "id",
            courseID: "course-id",
            courseSlug: "course-slug",
            chapterID: "article-id",
            chapterSlug: "article-slug",
            title: "Preview",
            index: 0
        ),
        isCompleted: false,
        isLocked: true,
        action: { }
    )
}
