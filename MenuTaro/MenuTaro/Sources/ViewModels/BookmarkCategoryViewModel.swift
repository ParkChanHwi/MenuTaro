//
//  BookmarkCategoryViewModel.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/25/25.
//

import SwiftUI
import SwiftData

final class BookmarkCategoryViewModel: ObservableObject {
    @Published var categoryCounts: [FoodCard.FoodCategory: Int] = [:]
    @Published var totalCount: Int = 0
    
    private var context: ModelContext?
    
    func setContext(_ context: ModelContext) {
        self.context = context
        fetchData()
    }
    
    private func fetchData() {
        guard let context else { return }
        
        let descriptor = FetchDescriptor<Bookmark>()
        if let bookmarks = try? context.fetch(descriptor) {
            var counts: [FoodCard.FoodCategory: Int] = [:]
            
            for bookmark in bookmarks {
                let category = bookmark.food.category
                counts[category, default: 0] += 1
            }
            
            self.categoryCounts = counts
            self.totalCount = bookmarks.count
        }
    }
}
