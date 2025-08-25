//
//  AllMenuCardView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/25/25.
//
import SwiftUI

struct AllMenuCardView: View {
    let title: String
    let imageName: String
    let count: Int
    let isActive: Bool
    let width: CGFloat
    let height: CGFloat
    
    init(
        title: String,
        imageName: String,
        count: Int,
        isActive: Bool,
        width: CGFloat = 362,
        height: CGFloat = 170
    ) {
        self.title = title
        self.imageName = imageName
        self.count = count
        self.isActive = isActive
        self.width = width
        self.height = height
    }
    
    var body: some View {
        GradientCardView(width: width, height: height, isActive: isActive) {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    HStack {
                        Text(title)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text("\(count)")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                    .frame(height: geometry.size.height * 0.35) // 상단 영역 35%
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: geometry.size.height * 1.2) // 이미지 영역 55%
                            .padding(.trailing, 20)
                    }
                }
            }
        }


    }
}
