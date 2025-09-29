//
//  MenuTaroSelectedView.swift
//  MenuTaro
//
//  Created by mac mini on 9/25/25.
//

import SwiftUI

struct MenuTaroSelectedView: View {
    @Binding var droppedCard: FoodCard
    
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            
            // 레이아웃 스케일링 파라미터
            let cardWidth   = min(w * 0.78, 360)               // 카드 최대 폭 제한
            let cardRatio   = 0.62                              // 카드 가로/세로 비율 (필요시 조정)
            let spacing     = max(16, w * 0.06)                 // 컴포넌트 간 간격
            let pillHeight  = max(41, w * 0.11)                 // 북마크 버튼 높이
            let pillWidth   = min(w * 0.56, 220)                // 북마크 버튼 폭
            let ctaHeight   = max(56, w * 0.14)                 // 메인 CTA 높이
            let sidePadding = max(20, w * 0.08)                 // 좌우 패딩
            
            VStack(spacing: spacing) {
                // 선택된 음식 카드
                CardFrontView(food: droppedCard)
                    .frame(width: cardWidth)
                    .aspectRatio(cardRatio, contentMode: .fit)
                
                // 북마크(알약) 버튼
                Button {
                    // execute: 북마크 토글 등
                } label: {
                    HStack(spacing: 8) {
                        Text("이 메뉴카드 저장")
                        Image(systemName: "bookmark")
                    }
                    .font(.system(size: max(14, w * 0.04), weight: .medium))
                    .foregroundColor(Color("buttonOrange"))
                    .frame(width: pillWidth, height: pillHeight)
                    .background(
                        Capsule()
                            .fill(Color.clear)
                    )
                    .overlay(
                        Capsule()
                            .stroke(Color("buttonOrange"), lineWidth: 1)
                    )
                }
                
                // 메인 CTA: 이 메뉴 먹을게요
                Button {
                    // execute: 확정 액션
                } label: {
                    Text("이 메뉴 먹을게요")
                        .font(.system(size: max(16, w * 0.045), weight: .semibold))
                        .frame(maxWidth: cardWidth, minHeight: ctaHeight)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color("buttonOrange"))
                .clipShape(RoundedRectangle(cornerRadius: max(14, ctaHeight/3), style: .continuous))
                
                // 다시 뽑을래요 (텍스트 버튼)
                Button {
                    // execute: 리롤/다시 뽑기
                } label: {
                    Text("다시 뽑을래요")
                        .font(.system(size: max(15, w * 0.042)))
                        .foregroundColor(Color("buttonGrey"))
                }
                
                Spacer(minLength: h * 0.06)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, sidePadding)
            .padding(.top, max(16, h * 0.04))
            .padding(.bottom, max(16, h * 0.04))
        }
    }
}

private struct MenuTaroSelectedPreview: View {
    @State private var card: FoodCard = PreviewData.sampleFoodKorean
    var body: some View {
        MenuTaroSelectedView(droppedCard: $card)
    }
}

#Preview("MenuTaroSelectedView") {
    MenuTaroSelectedPreview()
        .modelContainer(makePreviewContainer())
        .padding()
        .background(Color(.systemBackground))
}
