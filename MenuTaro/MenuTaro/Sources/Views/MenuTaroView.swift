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
    @Query var foodCards: [FoodCard]

    @State private var activeIndex: Int = 0
    @State private var droppedCard: FoodCard? = nil
    @State private var centerDropRect: CGRect = .zero
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.black, Color("primaryRed") ]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea(.all)
                
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: geometry.size.height * 0.15)
                    
                    // 중앙 카드 영역
                    VStack(spacing: 20) {
                        ZStack {
                            if let card = droppedCard {
                                //MARK: Card selected
                                
                                
                                
                            } else {
                                //MARK: Default
                                VStack() {
                                    Image("transparentCard")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.5)
                                        .opacity(1.0)
                                    
                                    Spacer()
                                    
                                    RadialLayoutView(
                                        items: foodCards,
                                        id: \.foodId,
                                        spacing: 0,
                                        dropTargetRect: centerDropRect,
                                        content: { foodCard, index, size in
                                            Cardcontent(foodCard: foodCard, index: index)
                                                .frame(width: size, height: size)
                                        },
                                        onIndexChange: { index in
                                            activeIndex = index
                                        },
                                        onCardSelected: { foodCard in
                                            droppedCard = foodCard
                                        }
                                    )
                                    .frame(height: geometry.size.height * 0.1)
                                    
                                    Spacer()
                                    Text("위로 드래그해서\n카드를 선택해주세요")
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 15, weight: .bold))
                                        .underline()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MenuTaroView()
        .modelContainer(makePreviewContainer())
}
