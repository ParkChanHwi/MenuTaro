//
//  AppSeedData.swift
//  MenuTaro
//
//  Created by mac mini on 10/5/23.
//

import Foundation

struct FoodCardSeed {
    let name: String
    let details: String
    let category: FoodCard.FoodCategory
    let image: String

    func makeModel() -> FoodCard {
        FoodCard(
            foodId: UUID(),
            name: name,
            details: details,
            category: category,
            image: image
        )
    }
}

enum AppSeedData {
    static let foodCards: [FoodCardSeed] = [
        FoodCardSeed(name: "불고기", details: "달콤짭짤 소고기 요리", category: .korean, image: "TestBookmark"),
        FoodCardSeed(name: "된장찌개", details: "구수한 된장찌개", category: .korean, image: "TestBookmark"),
        FoodCardSeed(name: "김치찌개", details: "돼지고기? 참치?", category: .korean, image: "TestBookmark"),
        FoodCardSeed(name: "콩나물 국밥", details: "계란 넣는 타이밍은?", category: .korean, image: "TestBookmark"),
        FoodCardSeed(name: "초밥", details: "한입에 즐기는 초밥", category: .japanese, image: "TestBookmark"),
        FoodCardSeed(name: "라멘", details: "뜨끈한 일본식 라멘", category: .japanese, image: "TestBookmark"),
        FoodCardSeed(name: "카츠", details: "겉바속촉 돈가츠", category: .japanese, image: "TestBookmark"),
        FoodCardSeed(name: "타코", details: "티키타코", category: .western, image: "Taco"),
        FoodCardSeed(name: "냉면", details: "여름 별미", category: .korean, image: "TestBookmark"),
        FoodCardSeed(name: "짜장면", details: "춘장 가득", category: .chinese, image: "TestBookmark"),
        FoodCardSeed(name: "짬뽕", details: "얼큰 국물", category: .chinese, image: "TestBookmark"),
        FoodCardSeed(name: "탕수육", details: "찍먹? 부먹?", category: .chinese, image: "TestBookmark"),
        FoodCardSeed(name: "우동", details: "쫄깃한 면발", category: .japanese, image: "TestBookmark"),
        FoodCardSeed(name: "회", details: "신선한 생선", category: .japanese, image: "TestBookmark")
    ]
}
