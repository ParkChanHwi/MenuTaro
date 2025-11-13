//
//  RecentMenuCardView.swift
//  MenuTaro
//
//  Created by 장현준 on 11/13/25.
//

import SwiftUI

struct RecentMenuCardView: View {
    let food: FoodCard

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(food.image.isEmpty ? "cardfront" : food.image)
                .resizable()
                .scaledToFill()
                .frame(width: 140, height: 140)
                .clipped()
                .cornerRadius(16)

            VStack(alignment: .leading, spacing: 4) {
                Text(food.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(1)

                Text(food.category.rawValue)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 140, alignment: .leading)
    }
}
