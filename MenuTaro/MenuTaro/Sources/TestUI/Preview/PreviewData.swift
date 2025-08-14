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
    
    static let sampleFoodJapanese = FoodCard(
        foodId: UUID(),
        name: "초밥",
        details: "한교동 운다",
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

