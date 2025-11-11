//
//  BookmarkCardView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/11/25.
//

import SwiftUI
import SwiftData

struct BookmarkCardView: View {
    let bookmark: Bookmark
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(bookmark.food.image.isEmpty ? "Cardfront" : bookmark.food.image)
                .resizable()
                .scaledToFill()
                .frame(width: 170, height: 170)
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
            .frame(width: 170, height: 170)
            .cornerRadius(16)
            
            HStack {
                Text(bookmark.food.name)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.leading, 4)
                    .lineLimit(1)
                Spacer()
                Image(systemName: "bookmark.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 14))
            }
            .padding(.trailing, 4)
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .frame(width: 170, height: 170)
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    BookmarkCardView(bookmark: PreviewData.sampleBookmark)
}
