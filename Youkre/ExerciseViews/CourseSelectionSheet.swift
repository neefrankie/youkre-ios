//
//  CourseSelectionSheet.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/11.
//

import SwiftUI

struct CourseSelectionSheet: View {
    @Binding var selectedCourse: Course
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List(Course.allCases) { course in
                Button(course.title) {
                    selectedCourse = course
                    dismiss()
                }
            }
            .navigationTitle("选择课程")
        }
    }
}

#Preview {
    @Previewable @State var selectedCourse: Course = .algebra
    CourseSelectionSheet(selectedCourse: $selectedCourse)
}
