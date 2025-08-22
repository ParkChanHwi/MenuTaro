//
//  MypageCardView.swift
//  MenuTaro
//
//  Created by 장현준 on 8/22/25.
//

import SwiftUI

struct MypageCardView: View {
    let mypage: Mypage
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(mypage.food.image)
                .resizable()
                .scaledToFill()
                .frame(width: 140, height: 140)
                .clipped()
                .cornerRadius(16)
            
            VStack(spacing: 0) {
                Spacer()
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.white.opacity(0.0), location: 0.0),
                                .init(color: .glassShadowBlack10.opacity(0.32), location: 0.32),
                                .init(color: .glassShadowBlack10.opacity(1.0), location: 1.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: 85)
            }
            .frame(width: 140, height: 140)
            .cornerRadius(16)
            
            HStack {
                Text(mypage.food.name)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.leading, 4)
                    .lineLimit(1)
                Spacer()
            }
            .padding(.trailing, 4)
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .frame(width: 140, height: 140)
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    MypageCardView(mypage: PreviewData.sampleMypage1)
}
