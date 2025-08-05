//
//  OnboardingView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/12.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnBoarding: Bool
    @State private var selected: CourseKind? = nil
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private func buttonColor(for course: CourseKind) -> Color {
        guard let selected else { return Color.clear}
        if course == selected {
            return Color.gray.opacity(0.5)
        } else {
            return Color.clear
        }
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("欢迎使用优克")
                
                .foregroundStyle(.secondary)
                
            Text("您目前想了解哪方面的数学知识：")
                .foregroundStyle(.secondary)
                .padding(.vertical, 16)
            
            LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                ForEach(CourseKind.allCases, id: \.self) { course in
                    Button(course.title) {
                        selected = course
                    }
                    .buttonStyle(
                        CapsuleBorderButtonStyle(
                            backgroundColor: buttonColor(for: course)
                        )
                    )
                }
            }
            .padding(.vertical, 16)
            
            Button("完成") {
                if let selected {
                    CourseSettings.selectedCourse = selected
                }
                self.hasCompletedOnBoarding = true
                    
            }
            .buttonStyle(CapsuleButtonStyle())
            .padding(.top, 32)
            
            Spacer()
            
        }
        .edgesIgnoringSafeArea(.all)
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            Button(action: {
                self.hasCompletedOnBoarding = true
            }) {
                Text("跳过")
                    .font(.caption)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .foregroundColor(.gray)
                    .background(
                        Capsule()
                            .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                    )
                    
            }
            .padding([.trailing, .bottom], 20)
        }
    }
}

#Preview {
    @Previewable @State var hasCompleted: Bool = false
    OnboardingView(hasCompletedOnBoarding: $hasCompleted)
}
