//
//  BundleImage.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/9/15.
//

import SwiftUI

struct BundleImage: View {
    let imagePath: String
    let placeholder: Image
    
    init(_ imagePath: String, placeholder: Image = Image(systemName: "photo")) {
        self.imagePath = imagePath
        self.placeholder = placeholder
    }
    
    var body: some View {
        Group {
            if let loadedImage = loadImageFromBundle(from: imagePath) {
                loadedImage
                    .resizable()
                    .scaledToFit()
            } else {
                placeholder
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.gray)
                    .frame(maxWidth: 100, maxHeight: 100)
                    .overlay(
                        Text("图片加载失败")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(4),
                        alignment: .bottom
                    )
            }
        }
    }
    
    func loadImageFromBundle(from path: String) -> Image? {
        let parsedResult = TextUtils.parseImagePath(path)
        
        guard let bundle = Bundle.main.webAssetsBundle else {
            print("Failed to find WebAssets.bundle")
            return nil
        }
        
        guard let imagePath = bundle.path(
            forResource: parsedResult.name,
            ofType: parsedResult.type,
            inDirectory: parsedResult.directory
        ), let uiImage = UIImage(contentsOfFile: imagePath) else {
            print("Failed to build image path")
            return nil
        }
        
        return Image(uiImage: uiImage)
    }
}

#Preview {
    BundleImage("/images/exercise/triangle-inequality-theorem--ex-10.png")
}
