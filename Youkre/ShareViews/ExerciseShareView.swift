//
//  ExerciseSharePreView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/24.
//

import SwiftUI

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        print(controller.view.intrinsicContentSize)
        
        let targetSize = UIScreen.main.bounds.size
        controller.view.frame = CGRect(origin: .zero, size: targetSize)
        
        // 确保视图已经布局完成
        controller.view.setNeedsLayout()
        controller.view.layoutIfNeeded()

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            print("Rendering view...")
            controller.view.drawHierarchy(
                in: CGRect(origin: .zero, size: targetSize),
                afterScreenUpdates: true
            )
        }
    }
}

struct ExerciseShareView: View {
    let exercise: ExerciseV2
    @Environment(\.displayScale) var displayScale
    @Environment(\.dismiss) var dismiss
    
    @State private var image: UIImage?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                ZStack {
                    Color.gray.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    
                    if let image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(30)
                    }
                }
                
                
                Divider()
                
                if let image {
                    ShareToolView(image: image)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("关闭", systemImage: "xmark") {
                        dismiss()
                    }
                }
            }
            .onAppear {
//                renderAndPreview()
                uiRender()
            }
        }
    }
    
    func uiRender() {
        let view = ExerciseRendererView(exercise: exercise)
        let image = view.snapshot()
        self.image = image
    }
    
    func renderAndPreview() {
        let renderer = ImageRenderer(
            content: ExerciseRendererView(exercise: exercise)
        )
        renderer.scale = displayScale
        
        if let uiImage = renderer.uiImage {
            image = uiImage
        } else {
            print("Failed to render image")
        }
    }
}

#Preview {    
    ExerciseShareView(
        exercise: ExerciseV2(
            id: "",
            levelId: "",
            prompts: [
                .table(GridTable(
                    data: [
                        ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月",],
                        ["1", "5", "11", "20", "26", "30", "30", "29", "25", "19", "10", "3"],
                    ],
                )),
                .image("triangle-exercise-1"),
                .text("求以下函数的导数："),
                .latex(#"y = x^{13}"#)
            ],
            multipleChoice: MultipleChoice(
                choices: [
                    #"12x^{12}"#,
                    #"13x^{12}"#,
                    #"13x^{14}"#,
                    #"14x^{13}"#,
                ],
                correctIndex: 1,
                isLatex: true
            ),
            explanation: nil
        )
    )
}
