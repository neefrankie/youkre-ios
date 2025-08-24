//
//  ExeriseSharePreviewView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/20.
//

import SwiftUI
import Photos

struct ExerciseSharePreviewSheet: View {
    let exercise: Exercise
    
    @Environment(\.dismiss) var dismiss
    @State private var renderedImage: Image?
    @Environment(\.displayScale) var displayScale
    
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 0) {
                
                ZStack {
                    Color.gray.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(30)
                }
                
                
                Divider()
                
                HStack(alignment: .center, spacing: 16) {
                    Spacer()
                    
                    
                    Button(action: {
                        saveImageToPhotosAlbum(image)
                    }) {
                        VStack {
                            Image(systemName: "square.and.arrow.down")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Text("保存到相册")
                        }
                    }
                    
                    Spacer()
                    
                    ShareLink(
                        item: Image(uiImage: image),
                        preview: SharePreview(
                            "发现一款超棒的数学学习助手——优克！快来试试吧！",
                            image: Image(uiImage: image)
                        )
                    ) {
                        VStack {
                            Image(systemName: "ellipsis.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Text("更多")
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.horizontal, 20)
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("关闭", systemImage: "xmark") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func render() async {
        let renderer = ImageRenderer(
            content: ExerciseShareView(exercise: exercise)
        )
        renderer.scale = displayScale
        
        if let uiImage = renderer.uiImage {
            renderedImage = Image(uiImage: uiImage)
        } else {
            print("Failed to render image")
        }
    }
    
    func saveImageToPhotosAlbum(_ image: UIImage) {
        // 检查当前授权状态
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized, .limited: // iOS 14+ 有限访问
            // 权限已授予，直接保存
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            print("图片已保存到相册")
            
        case .notDetermined:
            // 权限尚未请求，发起请求
            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    if newStatus == .authorized || newStatus == .limited {
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        print("用户授权，图片已保存")
                    } else {
                        print("用户拒绝授权")
                        // 可以提示用户去设置中开启
                    }
                }
            }
            
        case .denied, .restricted:
            // 权限被拒绝或受限
            print("相册访问被拒绝。请在设置中开启权限。")
            // 可以引导用户去设置
            // openSettings()
            
        @unknown default:
            fatalError("未知的授权状态")
        }
    }
}

#Preview {
    let renderer = ImageRenderer(
        content: ExerciseShareView(exercise: ExampleData.cmeLevel1Ex[0])
    )
    
    let uiImage = renderer.uiImage!
    
    ExerciseSharePreviewSheet(
        image: uiImage
    )
}
