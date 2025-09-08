//
//  MenuTaroView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/27/25.
//

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
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: geometry.size.height * 0.15)
                    
                    // 중앙 카드 영역
                    VStack(spacing: 20) {
                        ZStack {
                            if let card = droppedCard {
                                CardFrontView(food: card)  
                                    .frame(width: 189, height: 325)
                            } else {
                                Image("transparentCard")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 189, height: 325)
                                    .opacity(0.6)
                                Text("위로 드래그해서\n카드를 선택해주세요")
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 16, weight: .medium))
                            }
                        }
                        .background(
                            GeometryReader { proxy in
                                Color.clear
                                    .onAppear {
                                        centerDropRect = proxy.frame(in: .global)
                                    }
                                    .onChange(of: proxy.size) { _ in
                                        centerDropRect = proxy.frame(in: .global)
                                    }
                            }
                        )
                        
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.white)
                            .frame(width: 80, height: 4)
                    }
                    
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
                    .frame(height: geometry.size.height * 0.2)
                }
            }
        }
    }
}

#Preview {
    MenuTaroView()
        .modelContainer(makePreviewContainer())
}
