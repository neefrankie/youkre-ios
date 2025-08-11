//
//  CourseLauncherView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/6.
//

import SwiftUI

struct CourseListView: View {
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        LazyVGrid(columns: layout) {
            ForEach(Course.all) { course in
                NavigationLink(value: course) {
                    Text(course.title)
                }
                .frame(maxWidth: .infinity)
                .modifier(PaddedCardStyle())
            }
        }
        .padding()
    }
}



#Preview {
    CourseListView()
}
