//
//  PreviewData.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/14/25.
//

import Foundation

struct PreviewData {
    static let sampleFoodKorean = FoodCard(
        foodId: UUID(),
        name: "불고기",
        details: "달콤짭잘 소고기 요리",
        category: .korean,
        image: "TestBookmark"
    )
    
    static let sampleFoodKorean2 = FoodCard (
        foodId: UUID(),
        name: "된장찌개",
        details: "구수한 된장찌개",
        category: .korean,
        image: "TestBookmark"
        )
    
    static let sampleFoodKorean3 = FoodCard (
        foodId: UUID(),
        name: "김치찌개",
        details: "돼지고기? 참치?",
        category: .korean,
        image: "TestBookmark"
        )
    
    static let sampleFoodKorean4 = FoodCard (
        foodId: UUID(),
        name: "콩나물 국밥",
        details: "계란 넣는 타이밍은?",
        category: .korean,
        image: "TestBookmark"
        )
    
    static let sampleFoodJapanese = FoodCard(
        foodId: UUID(),
        name: "초밥",
        details: "한교동",
        category: .japanese,
        image: "TestBookmark"
    )
    
    static let sampleFoodJapanese2 = FoodCard(
        foodId: UUID(),
        name: "라멘",
        details: "라멘",
        category: .japanese,
        image: "TestBookmark"
    )
    
    static let sampleFoodJapanese3 = FoodCard(
        foodId: UUID(),
        name: "카츠",
        details: "최애",
        category: .japanese,
        image: "TestBookmark"
    )
    
    static let sampleSnack = Snack(
        snackId: UUID(),
        name: "마들렌",
        image: "cookie_snack"
    )
    
    static let sampleUser = User(
        nickname: "이병건",
        profileImage: ""
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
    static let sampleFoodExtra = [
        FoodCard(
            foodId: UUID(),
            name: "타코",
            details: "티키타코",
            category: .western,
            image: "Taco"
        ),
        FoodCard(
            foodId: UUID(),
            name: "냉면",
            details: "여름 별미",
            category: .korean,
            image: "TestBookmark"
        ),
        FoodCard(
            foodId: UUID(),
            name: "짜장면",
            details: "춘장 소스",
            category: .chinese,
            image: "TestBookmark"
        ),
        FoodCard(
            foodId: UUID(),
            name: "짬뽕",
            details: "얼큰 국물",
            category: .chinese,
            image: "TestBookmark"
        ),
        FoodCard(
            foodId: UUID(),
            name: "탕수육",
            details: "찍먹/부먹",
            category: .chinese,
            image: "TestBookmark"
        ),
        FoodCard(
            foodId: UUID(),
            name: "우동",
            details: "두꺼운 면",
            category: .japanese,
            image: "TestBookmark"
        ),
        FoodCard(
            foodId: UUID(),
            name: "회",
            details: "신선한 생선",
            category: .japanese,
            image: "TestBookmark"
        )
    ]
}
