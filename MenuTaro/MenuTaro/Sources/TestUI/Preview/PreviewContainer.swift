//
//  PreviewContainer.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/14/25.
//

import SwiftData
import Foundation

@MainActor
func makePreviewContainer() -> ModelContainer {
    let container = try! ModelContainer(
        for: Bookmark.self, FoodCard.self, User.self, Snack.self, ConsumptionRecord.self, Mypage.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let context = container.mainContext
    
    context.insert(PreviewData.sampleUser)
    
    let foods = [
        PreviewData.sampleFoodKorean,
        PreviewData.sampleFoodKorean2,
        PreviewData.sampleFoodKorean3,
        PreviewData.sampleFoodKorean4,
        PreviewData.sampleFoodJapanese,
        PreviewData.sampleFoodJapanese2,
        PreviewData.sampleFoodJapanese3,
        
    ]
    
    for food in foods {
        context.insert(food)
        let bookmark = Bookmark(
            bookmarkId: UUID(),
            createdAt: Date(),
            food: food,
            user: PreviewData.sampleUser
        )
        context.insert(bookmark)
    }
    //마이페이지 추가
    if foods.count >= 3 {
        let menuTop3: [Mypage] = [
            Mypage(rank: 1, food: foods[0], user: PreviewData.sampleUser),
            Mypage(rank: 2, food: foods[1], user: PreviewData.sampleUser),
            Mypage(rank: 3, food: foods[2], user: PreviewData.sampleUser),
        ]
        menuTop3.forEach { context.insert($0) }
    }
    
    try! context.save()
    return container
}
