//
//  CourseSelectionSheet.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/11.
//

import SwiftUI

struct CourseSelectionSheet: View {
    @State var selectedCourse = CourseSettings.selectedCourse {
        didSet {
            print("selected course: \(oldValue) -> \(selectedCourse)")
            if oldValue != selectedCourse {
                onSwitchCourse(selectedCourse)
            }
        }
    }
    @Environment(\.dismiss) var dismiss
    
    let onSwitchCourse: (CourseKind) -> Void
    
    var body: some View {
        NavigationStack {
            List(CourseKind.allCases) { course in
                
                Button(action: {
                    selectedCourse = course
                    dismiss()
                }) {
                    HStack {
                        Text(course.title)
                        Spacer()
                        if course == selectedCourse {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            .navigationTitle("选择课程")
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
    @Previewable @State var selectedCourse: CourseKind = .algebra
    CourseSelectionSheet(
        onSwitchCourse: { kind in
            print("Course changed \(kind)")
        }
    )
}
