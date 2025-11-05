//
//  Cardcontent.swift
//  MenuTaro
//
//  Created by 박찬휘 on 9/8/25.
//

import SwiftUI

struct Cardcontent: View {
    let foodCard: FoodCard
    let index: Int
    
    var body: some View {
        VStack {
            Image("cardback")
                .resizable()
                .scaledToFit()
                .frame(width: 125, height: 215)
                .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
            
        }
        
    }
    
}
