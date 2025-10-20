//
//  FoodCard.swift
//  MenuTaro
//
//  Created by 박찬휘 on 7/21/25.
//
import Foundation
import SwiftData


@Model
public class FoodCard {
    @Attribute(.unique) var foodId: UUID
    var name: String
    var details: String
    var category: FoodCategory
    var image: String
    
    
    public init(foodId: UUID, name: String, details: String, category: FoodCategory, image: String) {
        self.foodId = foodId
        self.name = name
        self.details = details
        self.category = category
        self.image = image
    }
    
    public enum FoodCategory: String, Codable, CaseIterable {
        case korean = "한식"
        case chinese = "중식"
        case western = "양식"
        case japanese = "일식"
        case etc = "기타"
    }

}
