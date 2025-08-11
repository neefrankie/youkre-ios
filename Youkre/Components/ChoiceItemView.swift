//
//  ChoiceItemView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/9.
//

import SwiftUI

struct ChoiceItemView: View {
    let choices: [ChoiceItem] = [
        ChoiceItem(text: "Option A", correct: false),
        ChoiceItem(text: "Opiton B", correct: false),
        ChoiceItem(text: "Option C", correct: true),
        ChoiceItem(text: "Opiton D", correct: false)
    ]
    
    @State private var selectedIndex: Int? = nil
    
    var body: some View {
        VStack {
            ForEach(choices.indices, id: \.self) { index in
                Button(action: {
                    print("Selected \(index)")
                    selectedIndex = index
                }) {
                    HStack {
                        Text(choices[index].text)
                            .fixedSize(horizontal: true, vertical: false)
                            .padding(.trailing, 20)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    .padding()
                    .background(
                        buttonColor(for: index)
                            .animation(.easeInOut(duration: 1), value: selectedIndex)
                    )
                    .cornerRadius(8)
                    .shadow(radius: 2)
                }
            }
        }
    }
    
    private func buttonColor(for index: Int) -> Color {
        if let selected = selectedIndex {
            if choices[index].correct {
                return .green.opacity(0.3)
            } else if index == selected {
                // indicates choices[index].correct is false.
                return .red.opacity(0.3)
            }
        }
        return AppColors.contentBackground
    }
}

#Preview {
    ChoiceItemView()
}
