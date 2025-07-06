//
//  MyColors.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/19.
//

import SwiftUI

enum AppColors {
    static let background = Color("GlobalBackground")
    static let contentBackground = Color("ContentBackground")
    static let graphAxes = Color("GraphAxes")
}

extension Color {
    init(hex: String) {
//        使用 trimmingCharacters(in:) 方法移除字符串中所有 非字母数字字符。
//        .alphanumerics.inverted 表示不是字母也不是数字的字符集合。
//        "#FF5733" -> "FF5733"
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
//        使用 Scanner 将 hex 字符串按 十六进制 转换为整数，并赋值给 int
//        解析成一个整数
        Scanner(string: hex).scanHexInt64(&int)
//        每个十六进制数字表示 4 位（bit），两个十六进制数字组成一个字节（8 bit）
//        FF → 1111 1111（即十进制的 255）
//        "FF5733" → FF (红)   57 (绿)   33 (蓝)
//                 → 11111111 01010111 00110011
//        int >> 16 表示向右移动 16 位：00000000 00000000 11111111
//        右移 8 位 00000000 11111111 01010111
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double((int) & 0xFF) / 255
        
        self.init(red: r, green: g, blue: b)
    }
}
