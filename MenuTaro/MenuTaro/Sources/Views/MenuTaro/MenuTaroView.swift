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
    @Query var foodCards: [FoodCard]
    
    @State private var centerDropRect: CGRect = .zero
    @State private var lastNavigatedFoodId: UUID?
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
                                .onAppear {
                                    centerDropRect = proxy.frame(in: .global)
                                }
                                .onChange(of: proxy.frame(in: .global)) { newValue in
                                    centerDropRect = newValue
                                }
                        }
                    )
                

                            Spacer()
                
                ZStack {
                    RadialLayoutView(
                        items: foodCards,
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
                            
                            Spacer()
                            Text("위로 드래그해서\n카드를 선택해주세요")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 15, weight: .bold))
                                .underline()
                
            }
        }
        .appBackgroundStyle(.gradient)
    }
}

#Preview {
    MenuTaroView()
        .modelContainer(makePreviewContainer())
        .environmentObject(Router())
}
