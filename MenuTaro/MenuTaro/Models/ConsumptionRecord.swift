//
//  ConsumptionRecord.swift
//  MenuTaro
//
//  Created by 박찬휘 on 7/21/25.
//
import Foundation
import SwiftData


@Model
class ConsumptionRecord {
    @Attribute(.unique) var recordId: UUID
    var timestamp: Date         
    var food: FoodCard?         
    var snack: Snack?           
    @Relationship(inverse: \User.records) var user: User
    
    init(recordId: UUID, timestamp: Date, food: FoodCard? = nil, snack: Snack? = nil, user: User) {
        self.recordId = recordId
        self.timestamp = timestamp
        self.food = food
        self.snack = snack
        self.user = user
    }
}
