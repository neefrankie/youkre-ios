//
//  ExplanationSheetView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/11.
//

import SwiftUI

struct ExplanationSheetView: View {
    let explanation: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                MarkdownView(
                    markdown: explanation,
                    latexFontSize: 22
                )
            }
            .padding()
            .navigationTitle("解析")
            .navigationBarTitleDisplayMode(.inline)
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
    ExplanationSheetView(
        explanation: ExampleData.cmeLevels[0].exercises[0].explanation!
    )
}
