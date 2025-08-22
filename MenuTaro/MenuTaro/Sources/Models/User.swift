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
    var profileImage:String
    var favoriteFood: FoodCard?
    var favoriteSnack: Snack?
    
    @Relationship var records: [ConsumptionRecord]
    @Relationship var bookmarks: [Bookmark]
    @Relationship var mypages: [Mypage] //마이페이지 추가

    init(userId: UUID = UUID(), nickname: String, profileImage:String,favoriteFood: FoodCard? = nil, favoriteSnack: Snack? = nil, records: [ConsumptionRecord] = [], bookmarks: [Bookmark] = [], mypages: [Mypage] = []) {
        self.userId = userId
        self.nickname = nickname
        self.profileImage = profileImage
        self.favoriteFood = favoriteFood
        self.favoriteSnack = favoriteSnack
        self.records = records
        self.bookmarks = bookmarks
        self.mypages = mypages //마이페이지 추가
    }
}
