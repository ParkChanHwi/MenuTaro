//
//  GradientCardView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/25/25.
//

import SwiftUI

struct GradientCardView<Content: View>: View {
    let width: CGFloat
    let height: CGFloat
    let isActive: Bool
    let content: Content
    
    init(
        width: CGFloat,
        height: CGFloat,
        isActive: Bool = true,   // 기본값 활성화
        @ViewBuilder content: () -> Content
    ) {
        self.width = width
        self.height = height
        self.isActive = isActive
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            if isActive {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 255/255, green: 73/255, blue: 35/255),
                        Color(red: 33/255, green: 33/255, blue: 33/255)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            } else {
                // 비활성화 상태일 때는 회색 단색 배경
                Color.gray.opacity(0.8)
            }
        }
        .frame(width: width, height: height)
        .cornerRadius(20)
        .shadow(radius: isActive ? 5 : 0)
        .overlay(content)
    }
}

#Preview {
    VStack(spacing: 20) {
        GradientCardView(width: 362, height: 80) {
            VStack {
                Text("🔥 메뉴 카드")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Gradient Background")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        
        GradientCardView(width: 150, height: 80) {
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(.pink)
                Text("작은 카드")
                    .foregroundColor(.white)
            }
        }
    }
}
