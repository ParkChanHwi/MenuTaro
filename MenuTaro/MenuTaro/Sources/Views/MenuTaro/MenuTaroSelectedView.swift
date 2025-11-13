//
//  MenuTaroSelectedView.swift
//  MenuTaro
//
//  Created by mac mini on 9/25/25.
//

import SwiftUI
import SwiftData

/// `MenuTaroSelectedView`
/// 사용자가 선택한 메뉴카드의 상세화면을 표시하는 View
/// 선택된 메뉴 정보를 보여주고, Bookmark 저장 및 "이 메뉴 먹을게요" 등의 버튼 제공
///
///  -Note: `MenuTaroSelectedViewModel`을 통해 데이터 상태를 관리하며,
///  `Router`를 활용하여 네비게이션 동작을 수행

struct MenuTaroSelectedView: View {
    /// SwiftData의 `ModelContext`를 주입받기 위한 Environment 값
    @Environment(\.modelContext) private var modelContext
    /// 화면 간 전환을 관리하는 Custom Router 객체
    @EnvironmentObject private var router: Router
    /// 선택된 메뉴카드의 상태 관리 `viewModel`
    @StateObject private var viewModel: MenuTaroSelectedViewModel
    
    /// 현재 View에서 표시할 `FoodCard` 데이터
    let foodCard: FoodCard

    /// `init`
    /// 주어진 `FoodCard`를 기반으로 ViewModel을 생성
    ///
    /// - Parameter foodCard: 선택된 메뉴카드 객체
    init(foodCard: FoodCard) {
        self.foodCard = foodCard
        _viewModel = StateObject(wrappedValue: MenuTaroSelectedViewModel(foodCard: foodCard))
    }
    var body: some View {
        GeometryReader { geo in
            /// 화면 별 일관성있는 레이아웃을 제공하기 위해 GeometryReader와 이를 기반으로한 metrics 사용
            let metrics = MenuTaroLayoutMetrics.metrics(for: geo.size)
            
            VStack(spacing: metrics.componentSpacing) {
                /// 선택된 메뉴카드의 전면 이미지를 표시하는 부분
                CardFrontView(food: foodCard)
                    .frame(width: metrics.cardWidth)
                    .aspectRatio(metrics.cardAspectRatio, contentMode: .fit)
                /// 북마크 저장 버튼
                Button {
                    viewModel.handleBookmarkTap()
                } label: {
                    HStack(spacing: 8) {
                        Text("이 메뉴카드 저장")
                        Image(systemName: viewModel.isBookmarked ? "bookmark.fill" : "bookmark")
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
                
                /// "이 메뉴 먹을게요" 버튼
                /// 메뉴 선택을 확정하고 섭취 목록에 추가
                /// 홈 화면으로 복귀
                Button {
                    viewModel.logConsumption()
                    router.popToRoot()
                } label: {
                    Text("이 메뉴 먹을게요")
                        .font(.system(size: metrics.callToActionFontSize, weight: .semibold))
                        .frame(height: metrics.callToActionHeight)
                }
                .buttonStyle(OrangeButtonStyle())
                .frame(maxWidth: metrics.cardWidth)

                /// "다시 뽑을래요" 버튼
                /// 카드 선택화면으로 이동
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
        .onAppear {
            /// ViewModel에 `ModelContext`를 주입하여 데이터 연동 초기화
            viewModel.setContext(modelContext)
        }
    }
}

/// `MenuTaroSelectedContainer`
///
/// `foodId`를 기반으로 SwiftData에서 해당 `FoodCard`를 조회하고,
/// 존재하는 경우 `MenuTaroSelectedView`를 표시
/// 데이터가 없을 경우, 에러 메시지를 표시
struct MenuTaroSelectedContainer: View {
    /// SwiftData의 쿼리를 통해 메뉴카드를 조회
    @Query private var foodCards: [FoodCard]

    /// `init`
    ///
    /// - Parameter foodId : 표시할 메뉴카드의 ID
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
