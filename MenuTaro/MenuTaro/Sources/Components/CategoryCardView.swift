//
//  CategoryCardView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/25/25.
//
import SwiftUI


struct CategoryCardView: View {
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
        height: CGFloat = 80   // 기본값은 일반 카테고리 크기
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
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: height * 1.2, height: height * 1.8) // 카드 크기에 비례
                
                Text(title)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(count)")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                    .padding(.trailing, 12)
            }
        }
    }
}
