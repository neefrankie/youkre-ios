//
//  ExerciseChoiceView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/22.
//

import SwiftUI

struct OptionItemView: View {
    let choice: String
    let isLatex: Bool
    let correctIndex: Int
    let optionIndex: Int
    
    var selectedIndex: Int? = nil
    
    var body: some View {
        HStack {
            if isLatex {
                MathView(
                    latex: choice,
                    labelMode: .text,
                    textAlignment: .left,
                    textColor: .primary
                )
                .fixedSize(horizontal: false, vertical: true)
            } else {
                Text(choice)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.trailing, 20)
                    .foregroundColor(.primary)
            }
            
            // This also makes the button full width.
            Spacer()
            
            trailingImage(
                for: optionIndex,
                correctIndex: correctIndex,
            )
            .frame(width: 20, height: 20)
        }
        .padding()
        .background(
            buttonColor(
                for: optionIndex,
                correctIndex: correctIndex
            )
            .animation(
                .easeInOut(duration: 0.4),
                value: selectedIndex,
            )
        )
        .cornerRadius(8)
        .shadow(radius: 2)
    }
    
    private func trailingImage(for index: Int, correctIndex: Int) -> some View {
        if let selected = selectedIndex {
            // Only add mark to selected one.
            if index == selected {
                // Index is selected and it is the correct index.
                if index == correctIndex {
                    return Image(systemName: "checkmark")
                        .foregroundColor(.green)
                } else {
                    return Image(systemName: "xmark")
                        .foregroundColor(.red)
                }
            }
        }
        
        return Image(systemName: "")
            .foregroundColor(.clear)
    }
    
    private func buttonColor(for index: Int, correctIndex: Int) -> Color {
        // If ther's a choice, it indicates the answer is selected and exercise is not skipped.
        if let selected = selectedIndex {
            // Correct answer always show green background after user make choice.
            if index == correctIndex {
                return .green.opacity(0.3)
            } else if index == selected {
                // Implicilty indicated this index != correcIndex
                // index is not the correntIndex but is selected, so it's not correct.
                return .red.opacity(0.3)
            }
        }
        
//        return .gray.opacity(0.1)
        return AppColors.contentBackground
    }
}

#Preview {
    ChoiceItemView()
}
