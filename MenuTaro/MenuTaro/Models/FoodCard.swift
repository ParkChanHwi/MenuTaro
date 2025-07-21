//
//  FoodCard.swift
//  MenuTaro
//
//  Created by 박찬휘 on 7/21/25.
//
import Foundation
import SwiftData


@Model
class FoodCard {
    @Attribute(.unique) var foodId: UUID
    var name: String
    var details: String
    var category: FoodCategory
    var image: String
    
    
    init(foodId: UUID, name: String, details: String, category: FoodCategory, image: String) {
        self.foodId = foodId
        self.name = name
        self.details = details
        self.category = category
        self.image = image
    }
    
    enum FoodCategory: String, Codable {
        case korean = "한식"
        case chinese = "중식"
        case western = "양식"
        case japanese = "일식"
        case etc = "기타"
    }

}
