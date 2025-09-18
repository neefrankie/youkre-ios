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
        
        print(parsedResult)
        
        if parsedResult.isSvg || parsedResult.isPdf {
            return loadPdfImage(from: parsedResult)
        }
        
        return loadBinaryImage(from: parsedResult)
    }
    
    func loadBinaryImage(from path: ParsedPath) -> Image? {
        guard let bundle = Bundle.main.webAssetsBundle else {
            print("Failed to find WebAssets.bundle")
            return nil
        }
        
        guard let imagePath = bundle.path(
            forResource: path.name,
            ofType: path.suffix,
            inDirectory: path.directory
        ) else {
            print("Failed to build image path")
            return nil
        }
        
        print(imagePath)
        
        guard let uiImage = UIImage(contentsOfFile: imagePath) else {
            print("Failed to load UIImage")
            return nil
        }
        
        return Image(uiImage: uiImage)
    }
    
    func loadPdfImage(from path: ParsedPath) -> Image? {
        guard let bundle = Bundle.main.webAssetsBundle else {
            print("Failed to find WebAssets.bundle")
            return nil
        }
        
        guard let url = bundle.url(
            forResource: path.name,
            withExtension: "pdf",
            subdirectory: path.directory,
        ) else {
            print("Failed to build url for \(path)")
            return nil
        }
        
        print("Image url: \(url)")
        
        guard let data = try? Data(contentsOf: url),
              let provider = CGDataProvider(data: data as CFData),
              let document = CGPDFDocument(provider),
              let page = document.page(at: 1)
        else {
            print("Failed to load PDF document")
            return nil
        }
        
        // 获取 PDF 原始尺寸（如 72dpi 下的宽高）
        let pdfRect = page.getBoxRect(.mediaBox)
        let pdfSize = pdfRect.size
        
        // 👇 关键：设置目标渲染尺寸（可根据需要调整）
        let targetSize = CGSize(width: 300, height: 150)
        
        // 创建高清渲染器（自动使用 @2x/@3x 分辨率）
        let renderer = UIGraphicsImageRenderer(
            size: targetSize,
            format: UIGraphicsImageRendererFormat.preferred()
        )
        
        let image = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.systemBackground.cgColor)
            ctx.cgContext.fill(CGRect(origin: .zero, size: targetSize))
            
            // 计算缩放比例，保持宽高比
            let scale = min(targetSize.width / pdfSize.width,
                           targetSize.height / pdfSize.height)
            
            // 居中
            let x = (targetSize.width - pdfSize.width * scale) / 2
            let y = (targetSize.height - pdfSize.height * scale) / 2
            
            // 应用变换
            ctx.cgContext.translateBy(x: x, y: y)
            ctx.cgContext.scaleBy(x: scale, y: scale)
            
            // 👉 翻转 Y 轴（PDF 坐标系 Y 向上，UIKit 向下）
            ctx.cgContext.translateBy(x: 0, y: pdfSize.height)
            ctx.cgContext.scaleBy(x: 1, y: -1)
            
            // 绘制 PDF 页面
            ctx.cgContext.drawPDFPage(page)
        }
        
        return Image(uiImage: image)
    }
}

#Preview {
    BundleImage("/images/exercise/elementary-statistics--score-on-a-die.pdf")
}
