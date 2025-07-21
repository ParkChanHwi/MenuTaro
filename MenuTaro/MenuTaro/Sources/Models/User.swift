//
//  User.swift
//  MenuTaro
//
//  Created by 박찬휘 on 7/21/25.
//
import Foundation
import SwiftData

@Model
class User {
    @Attribute(.unique) var userId: UUID
    var nickname: String
    var favoriteFood: FoodCard?
    var favoriteSnack: Snack?
    
    @Relationship var records: [ConsumptionRecord]
    @Relationship var bookmarks: [Bookmark]

    init(userId: UUID = UUID(), nickname: String, favoriteFood: FoodCard? = nil, favoriteSnack: Snack? = nil, records: [ConsumptionRecord] = [], bookmarks: [Bookmark] = []) {
        self.userId = userId
        self.nickname = nickname
        self.favoriteFood = favoriteFood
        self.favoriteSnack = favoriteSnack
        self.records = records
        self.bookmarks = bookmarks
    }
}
