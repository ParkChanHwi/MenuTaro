//
//  RankingCardView.swift
//  MenuTaro
//
//  Created by 장현준 on 10/31/25.
//

import SwiftUI

struct RankingCardView: View {
    let rank: Int
    let name: String
    let image: String
    let countText: String
    let isTop3: Bool

    var body: some View {
        HStack(spacing: 12) {
            //순위
            Text("\(rank)")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 28)

            //음식 이미지
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white.opacity(0.2), lineWidth: 1)
                )

            //음식 이름
            Text(name)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)

            //횟수 텍스트
            Text(countText)
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.9))
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    {
                        if isTop3 {
                            switch rank {
                            case 1: Color(red: 1, green: 0.29, blue: 0.14) // 1위
                            case 2: Color(red: 1, green: 0.29, blue: 0.14).opacity(0.8) // 2위
                            case 3: Color(red: 1, green: 0.29, blue: 0.14).opacity(0.6) // 3위
                            default: Color.white.opacity(0.06)
                            }
                        } else {
                            Color.white.opacity(0.06)
                        }
                    }()
                )
        )
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 10) {
            RankingCardView(rank: 1, name: "아이스크림", image: "ice", countText: "최근 30일 내 3회", isTop3: true)
            RankingCardView(rank: 2, name: "라면", image: "ramen", countText: "최근 30일 내 2회", isTop3: true)
            RankingCardView(rank: 3, name: "김밥", image: "gimbap", countText: "최근 30일 내 1회", isTop3: true)
            RankingCardView(rank: 4, name: "피자", image: "pizza", countText: "최근 30일 내 1회", isTop3: false)
        }
        .padding()
    }
}
