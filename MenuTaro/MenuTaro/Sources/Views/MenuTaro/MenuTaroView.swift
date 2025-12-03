//
//  MenuTaroView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/27/25.
//
/* 참고 코드 https://seons-dev.tistory.com/entry/Colors-and-Gradient#google_vignette
 */

import SwiftUI
import SwiftData

struct MenuTaroView: View {
    @EnvironmentObject private var router: Router
    @Query(sort: \FoodCard.name, order: .forward)
    var foodCards: [FoodCard]
    
    @State private var centerDropRect: CGRect = .zero
    @StateObject private var viewModel = MenuTaroViewModel()
    
    // 덱을 구성하는 카드 수
    private let deckCardLimit = 25
    
    // 코드 가독성을 높이기 위한 Modifier
    private var deckCards: [FoodCard] {
        viewModel.deckCards
    }
    private var hasDeck: Bool { !deckCards.isEmpty }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                Spacer()
                Image("transparentCard")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.5)
                    .opacity(1.0)
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                            //드래그 감지를 위해 드롭 대상의 프레임을 전역 좌표로 캡처
                                .onAppear {
                                    centerDropRect = proxy.frame(in: .global)
                                }
                                .onChange(of: proxy.frame(in: .global)) { newValue in
                                    centerDropRect = newValue
                                }
                        }
                    )
                
                Spacer()
                
                if hasDeck {
                    ZStack {
                        RadialLayoutView(
                            items: deckCards,
                            id: \.foodId,
                            spacing: 0,
                            dropTargetRect: centerDropRect,
                            content: { foodCard, index, size in
                                Cardcontent(foodCard: foodCard, index: index)
                                    .frame(width: size, height: size)
                            },
                            onCardSelected: { foodCard in
                                router.push(.MenuTaroSelected(foodId: foodCard.foodId))
                            }
                        )
                        .frame(height: geometry.size.height * 0.1)
                    }
                } else {
                    Text("카드를 불러오는 중입니다…")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: geometry.size.height * 0.1)
                }
                
                Spacer()
                Text("카드를 꾹 누른 뒤\n위로 드래그 해 선택해 주세요")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 15, weight: .bold))
                    .underline()
            }
        }
        .appBackgroundStyle(.gradient)
        .onAppear {
            // 뷰가 처음 나타날 때 카드 덱을 구성
            viewModel.buildDeck(from: foodCards)
        }
        .onChange(of: foodCards) { updatedCards in
            // SwiftData 레코드가 변경될 때마다 카드 덱을 다시 구성
            viewModel.buildDeck(from: updatedCards)
        }
    }
}

#Preview {
    MenuTaroView()
        .modelContainer(makePreviewContainer())
        .environmentObject(Router())
}
