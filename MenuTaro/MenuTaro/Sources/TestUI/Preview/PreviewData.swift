//
//  PreviewData.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/14/25.
//

import Foundation

struct PreviewData {
    private static func makeFood(named name: String) -> FoodCard {
        if let seed = AppSeedData.foodCards.first(where: { $0.name == name }) {
            return seed.makeModel()
        }

        return FoodCard(
            foodId: UUID(),
            name: name,
            details: "미리보기 전용 데이터",
            category: .etc,
            image: "Taco"
        )
    }

    static let sampleFoodKorean = makeFood(named: "떡볶이")
    static let sampleFoodKorean2 = makeFood(named: "라볶이")
    static let sampleFoodKorean3 = makeFood(named: "쫄면")
    static let sampleFoodKorean4 = makeFood(named: "김밥")

    static let sampleFoodJapanese = makeFood(named: "꿔바로우")
    static let sampleFoodJapanese2 = makeFood(named: "마라탕")
    static let sampleFoodJapanese3 = makeFood(named: "마라샹궈")

    static let sampleSnack = Snack(
        snackId: UUID(),
        name: "마들렌",
        image: "cookie_snack"
    )

    static let sampleUser = User(
        nickname: "이병건",
        profileImage: "chicken"
    )

    static let sampleBookmark = Bookmark(
        bookmarkId: UUID(),
        createdAt: Date(),
        food: sampleFoodJapanese,
        user: sampleUser
    )

    static let sampleRecord = ConsumptionRecord(
        recordId: UUID(),
        timestamp: Date(),
        food: sampleFoodKorean,
        snack: nil,
        user: sampleUser
    )
}

extension PreviewData {
    static let sampleFoodExtra: [FoodCard] = [
        "짜장면",
        "짬뽕",
        "탕수육",
        "포테이토 피자",
        "페퍼로니 피자",
        "고르곤졸라 피자",
        "토마토 스파게티",
        "햄버거",
        "로제 파스타",
        "부리토"
    ].map { makeFood(named: $0) }
}
