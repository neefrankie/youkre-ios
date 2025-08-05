//
//  CourseSelectionSheet.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/11.
//

import SwiftUI

struct CourseSelectionSheet: View {
    @Binding var selectedCourse: CourseKind
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List(CourseKind.allCases) { course in
                Button(course.title) {
                    selectedCourse = course
                    dismiss()
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
        selectedCourse: $selectedCourse,
    )
}
