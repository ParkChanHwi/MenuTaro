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
                ZStack(alignment: .top) {
                    
                    // 이미지: 카드 바닥에 붙이고, 위쪽 잘리게
                    VStack {
                        Spacer() // 바닥으로 밀기
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(
                                width: geometry.size.width * 0.9,
                                height: geometry.size.height * 1.2,
                                alignment: .bottomLeading // 수정 부분
                            )
                            .offset(y: 30) // 수정 부분
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped() // 카드 영역 넘어가는 건 잘라냄
                    
                    // 상단 텍스트
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
                }
            }
        }
    }
}

#Preview {
    BookmarkCategoryListView()
        .modelContainer(makePreviewContainer())
}
