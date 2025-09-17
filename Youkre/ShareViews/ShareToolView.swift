//
//  ShareToolView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/24.
//

import SwiftUI
import Photos

struct ShareToolView: View {
    // 当一个 IUO（如 UIImage!）为 nil 并被访问时，崩溃可能发生在后续任意使用 UI 的地方，但堆栈会指向“最近的 UI 操作”。
    // UIImage 是 引用类型，它可能为 nil（比如加载失败、路径错误、内存不足等）
    let image: UIImage
    
    @State private var showPermissionAlert = false
    
    var body: some View {
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
        .alert(isPresented: $showPermissionAlert) {
            Alert(
                title: Text("相册访问被拒绝"),
                message: Text("请在设置中开启相册权限以便保存图片。"),
                primaryButton: .default(Text("去设置")) {
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(appSettings) {
                            UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                        }
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    func saveImageToPhotosAlbum(_ image: UIImage) {
        // 检查当前授权状态
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized, .limited: // iOS 14+ 有限访问
            // 如果 image 是 nil，这个函数会立即崩溃，但因为它是 C 函数，不会抛出 Swift 异常，崩溃堆栈会“漂移”到下一个 UI 操作，也就是：
            // 权限已授予，直接保存
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            ToastManager.shared.show(text: "图片已保存")
            
        case .notDetermined:
            // 权限尚未请求，发起请求
            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    if newStatus == .authorized || newStatus == .limited {
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        ToastManager.shared.show(text: "图片已保存")
                    } else {
                        ToastManager.shared.show(text: "未授权访问相册")
                        // 可以提示用户去设置中开启
                    }
                }
            }
            
        case .denied, .restricted:
            // 权限被拒绝或受限
            showPermissionAlert = true
            
        @unknown default:
            ToastManager.shared.show(text: "未知错误")
        }
    }
}

#Preview {    
    let view = ExerciseShareView(exercise: ExampleData.cmeLevel1Ex[0])
    
    let uiImage = view.snapshot()
    
    ShareToolView(
        image: uiImage
    )
    .toast()
}
