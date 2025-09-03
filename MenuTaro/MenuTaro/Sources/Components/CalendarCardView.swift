//
//  CalendarCardView.swift
//  MenuTaro
//
//  Created by 장현준 on 9/2/25.
//

import SwiftUI

struct CalendarCardView: View {
    let image: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipped()
                .cornerRadius(16)
            
            VStack(spacing: 0) {
                Spacer()
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.white.opacity(0.0), location: 0.0),
                                .init(color: .glassShadowBlack10.opacity(0.32), location: 0.32),
                                .init(color: .glassShadowBlack10.opacity(1.0), location: 1.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: 85)
            }
            .frame(width: 120, height: 120)
            .cornerRadius(16)
            
        }
        .frame(width: 120, height: 120)
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    CalendarCardView(
        image: PreviewData.sampleFoodKorean.image
    )
}

