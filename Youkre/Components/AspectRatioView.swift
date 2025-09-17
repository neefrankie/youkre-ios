//
//  AspectRatioCardView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/6.
//

import SwiftUI

struct AspectRatioView<Content: View>: View {
    var ratio: CGFloat = 16/9
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = width / ratio
            
            ZStack {
                content()
                    .frame(width: width, height: height)
            }
            .frame(width: width, height: height)
        }
        .aspectRatio(ratio, contentMode: .fit)
    }
}

#Preview {
    AspectRatioView() {
        VStack {
            Image("calculus-made-easy")
                .resizable()
                .scaledToFit()
                .border(.red)
        }
    }
    .border(.yellow)
}
