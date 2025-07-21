//
//  Snack.swift
//  MenuTaro
//
//  Created by 박찬휘 on 7/21/25.
//
import Foundation
import SwiftData


@Model
class Snack {
    @Attribute(.unique) var snackId: UUID
    var name: String
    var image: String
    
    init(snackId: UUID, name: String, image: String) {
        self.snackId = snackId
        self.name = name
        self.image = image
    }
}
