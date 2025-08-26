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
                ZStack {
                    // 상단 텍스트 영역
                    VStack {
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
                        
                        Spacer() // 텍스트를 상단에 고정
                    }
                    
                    // 이미지 영역 (하단에 배치하되 잘리도록)
                    VStack {
                        Spacer()
                        HStack {
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 1.2)
                                .offset(x: -30) // 이미지만 왼쪽으로 30포인트 이동
                            Spacer()
                        }
                        .padding(.bottom, -60) // 하단으로 밀어서 일부가 잘리게
                    }
                    .clipped()
                }
            }
        }
    }
}
