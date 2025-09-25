//
//  MenuTaroSelectedView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 9/19/25.
//

import SwiftUI

struct MenuTaroSelectedView: View {
    @Binding var droppedCard: FoodCard
    var body: some View {
        VStack(spacing : 20) {
            // 선택된 음식 카드 뷰
            CardFrontView(food: droppedCard)
            
            // 버튼 1. 북마크 버튼, 2. 이 메뉴 먹을래요 버튼, 3. 다시 뽑을래요 버튼
            
            
            
            
        }
    }
}

#Preview {
    //    MenuTaroSelectedView()
}
