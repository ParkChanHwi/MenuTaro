//
//  MenuTaroSelectedView.swift
//  MenuTaro
//
//  Created by mac mini on 9/25/25.
//

import SwiftUI
import SwiftData

struct MenuTaroSelectedView: View {
    @EnvironmentObject private var router: Router
    let foodCard: FoodCard

    var body: some View {
        GeometryReader { geo in
            let metrics = MenuTaroLayoutMetrics.metrics(for: geo.size)

            VStack(spacing: metrics.componentSpacing) {
                CardFrontView(food: foodCard)
                    .frame(width: metrics.cardWidth)
                    .aspectRatio(metrics.cardAspectRatio, contentMode: .fit)

                Button {
                    // execute: 북마크 토글 등
                } label: {
                    HStack(spacing: 8) {
                        Text("이 메뉴카드 저장")
                        Image(systemName: "bookmark")
                    }
                    .font(.system(size: metrics.bookmarkFontSize, weight: .medium))
                    .foregroundColor(Color("buttonOrange"))
                    .frame(width: metrics.bookmarkPillSize.width, height: metrics.bookmarkPillSize.height)
                    .background(
                        Capsule()
                            .fill(Color.clear)
                    )
                    .overlay(
                        Capsule()
                            .stroke(Color("buttonOrange"), lineWidth: 1)
                    )
                }

                Button {
                    router.popToRoot()
                } label: {
                    Text("이 메뉴 먹을게요")
                        .font(.system(size: metrics.callToActionFontSize, weight: .semibold))
                        .frame(height: metrics.callToActionHeight)
                }
                .buttonStyle(OrangeButtonStyle())
                .frame(maxWidth: metrics.cardWidth)

                Button {
                    router.pop()
                } label: {
                    Text("다시 뽑을래요")
                        .font(.system(size: max(15, geo.size.width * 0.042)))
                        .foregroundColor(Color("buttonGrey"))
                }

                Spacer(minLength: metrics.bottomSpacer)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, metrics.horizontalPadding)
            .padding(.top, metrics.verticalPadding)
            .padding(.bottom, metrics.verticalPadding)
        }
        .appBackgroundStyle(.gradient)
    }
}

struct MenuTaroSelectedContainer: View {
    @Query private var foodCards: [FoodCard]

    init(foodId: UUID) {
        _foodCards = Query(filter: #Predicate { $0.foodId == foodId })
    }
    var body: some View {
        Group {
            if let card = foodCards.first {
                MenuTaroSelectedView(foodCard: card)
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                    Text("선택한 메뉴를 찾을 수 없습니다.")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white)

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .appBackgroundStyle(.gradient)
            }
        }
    }
}

#Preview("MenuTaroSelectedView") {
    MenuTaroSelectedContainer(foodId: PreviewData.sampleFoodKorean.foodId)
        .environmentObject(Router())
        .padding()
        .background(Color(.systemBackground))
}
