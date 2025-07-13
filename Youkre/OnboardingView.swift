//
//  OnboardingView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/12.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnBoarding: Bool
    @State private var selected: Course? = nil
    
    let columns = [
        GridItem(.adaptive(minimum: 100), spacing: 5)
    ]
    
    private func buttonColor(for course: Course) -> Color {
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
            
            LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                ForEach(Course.allCases, id: \.self) { course in
                    Button(action: {
                        selected = course
                    }) {
                        Text(course.title)
                            .font(.caption)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .foregroundColor(.gray)
                            .background(
                                Capsule()
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                                    .background(Capsule().fill(buttonColor(for: course)))
                            )
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            .padding(.vertical, 16)
            
            Button(action: {
                if let selected {
                    AppSettings.selectedCourse = selected
                }
                self.hasCompletedOnBoarding = true
            }) {
                Text("完成")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .foregroundStyle(.teal)
                    .background(
                        Capsule()
                            .stroke(Color.teal, lineWidth: 2)
                    )
                    
            }
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
