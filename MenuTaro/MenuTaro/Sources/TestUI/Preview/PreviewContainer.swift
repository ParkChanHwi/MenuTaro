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
        for: Bookmark.self, FoodCard.self, User.self, Snack.self, ConsumptionRecord.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let context = container.mainContext
    
    context.insert(PreviewData.sampleUser)
    
    let foods = [
        PreviewData.sampleFoodKorean,
        PreviewData.sampleFoodJapanese
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
    
    try! context.save()
    return container
}
