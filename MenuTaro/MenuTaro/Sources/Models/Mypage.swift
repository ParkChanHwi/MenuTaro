//
//  Mypage.swift
//  MenuTaro
//
//  Created by 장현준 on 8/22/25.
//

import Foundation
import SwiftData

@Model
class Mypage {
    @Attribute(.unique) var mypageId: UUID
    var createdAt: Date
    var rank: Int
    @Relationship var food: FoodCard
    @Relationship(inverse: \User.mypages) var user: User

    init(mypageId: UUID = UUID(), createdAt: Date = Date(),
         rank: Int, food: FoodCard, user: User) {
        self.mypageId = mypageId
        self.createdAt = createdAt
        self.rank = rank
        self.food = food
        self.user = user
    }
}
