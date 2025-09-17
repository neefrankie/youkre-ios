//
//  LevelSummarySheet.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/9.
//

import SwiftUI

struct LevelSummarySheet: View {
    
    @Environment(\.dismiss) var dismiss
    
    let levelProgress: LevelProgress?
    let hasNextLevel: Bool
    let allLevelsComplete: Bool
    
    var onRestart: () -> Void
    var onNextLevel: () -> Void
    var onFinish: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("🎉完成本节练习")
                    .font(.largeTitle.bold())
                if let levelProgress {
                    Text("答对 \(levelProgress.score) / \(levelProgress.total)")
                }
                
                HStack {
                    Button("再做一遍") {
                        onRestart()
//                        dismiss()
                    }
                    .buttonStyle(CapsuleButtonStyle())
                    
                    if hasNextLevel {
                        Button("下一节") {
                            onNextLevel()
//                            dismiss()
                        }
                        .buttonStyle(CapsuleButtonStyle())
                    } else if allLevelsComplete {
                        Button("已完成所有练习") {
                            onFinish()
//                            dismiss()
                        }
                        .buttonStyle(CapsuleBorderButtonStyle(
                            verticalPadding: 12,
                            horizontalPadding: 24,
                        ))
                    } else {
                        Button("结束") {
                            onFinish()
                            dismiss()
                        }
                        .buttonStyle(CapsuleBorderButtonStyle(
                            verticalPadding: 12,
                            horizontalPadding: 24,
                        ))
                    }
                    
                }
                .padding(.top)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("关闭") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    LevelSummarySheet(
        levelProgress: LevelProgress(
            id: UUID(),
            levelID: "example-level",
            score: 8,
            total: 10,
            startedAt: Date(),
        ),
        hasNextLevel: false,
        allLevelsComplete: true,
        onRestart: { },
        onNextLevel: { },
        onFinish: { }
    )
}
