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
    /*
    context.insert(PreviewData.sampleSnack)
    func addFoodRecord(_ food: FoodCard, times: Int) {
            for _ in 0..<times {
                let rec = ConsumptionRecord(
                    recordId: UUID(),
                    timestamp: Date(),
                    food: food,
                    snack: nil,
                    user: PreviewData.sampleUser
                )
                context.insert(rec)
            }
        }
        func addSnackRecord(_ snack: Snack, times: Int) {
            for _ in 0..<times {
                let rec = ConsumptionRecord(
                    recordId: UUID(),
                    timestamp: Date(),
                    food: nil,
                    snack: snack,
                    user: PreviewData.sampleUser
                )
                context.insert(rec)
            }
        }
    if foods.count >= 3 {
           addFoodRecord(foods[0], times: 3)
           addFoodRecord(foods[1], times: 2)
           addFoodRecord(foods[2], times: 1)
       }
    addSnackRecord(PreviewData.sampleSnack, times: 4)
    */
    func dateBy(dayOffset: Int, hour: Int, minute: Int = 0) -> Date {
        var comps = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        comps.hour = hour
        comps.minute = minute
        let base = Calendar.current.date(from: comps)!
        return Calendar.current.date(byAdding: .day, value: dayOffset, to: base)!
    }

    // 오늘: 아침(불고기), 오후 간식(마들렌), 저녁(초밥)
    context.insert(
        ConsumptionRecord(
            recordId: UUID(),
            timestamp: dateBy(dayOffset: 0, hour: 8),
            food: PreviewData.sampleFoodKorean,   // 불고기
            snack: nil,
            user: PreviewData.sampleUser
        )
    )
    context.insert(
        ConsumptionRecord(
            recordId: UUID(),
            timestamp: dateBy(dayOffset: 0, hour: 15),
            food: nil,
            snack: PreviewData.sampleSnack,       // 마들렌
            user: PreviewData.sampleUser
        )
    )
    context.insert(
        ConsumptionRecord(
            recordId: UUID(),
            timestamp: dateBy(dayOffset: 0, hour: 19),
            food: PreviewData.sampleFoodJapanese, // 초밥
            snack: nil,
            user: PreviewData.sampleUser
        )
    )

    // 어제: 점심(된장찌개)
    context.insert(
        ConsumptionRecord(
            recordId: UUID(),
            timestamp: dateBy(dayOffset: -1, hour: 12),
            food: PreviewData.sampleFoodKorean2,  // 된장찌개
            snack: nil,
            user: PreviewData.sampleUser
        )
    )
    
    try! context.save()
    return container
}
