//
//  Bookmark.swift
//  MenuTaro
//
//  Created by 박찬휘 on 7/21/25.
//
import Foundation
import SwiftData


@Model
class Bookmark {
    @Attribute(.unique) var bookmarkId: UUID
    var createdAt: Date
    @Relationship var food: FoodCard
    @Relationship(inverse: \User.bookmarks) var user: User
    
    init(bookmarkId: UUID, createdAt: Date, food: FoodCard, user: User) {
        self.bookmarkId = bookmarkId
        self.createdAt = createdAt
        self.food = food
        self.user = user
    }
}
