//
//  BookmarkViewModel.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/11/25.
//

import SwiftUI
import SwiftData

@MainActor
final class BookmarkViewModel: ObservableObject {
    private var context: ModelContext?
    @Published var bookmarks: [Bookmark] = []
    private let category: FoodCard.FoodCategory?

    init(category: FoodCard.FoodCategory? = nil) {
        self.category = category
    }

    func setContext(_ context: ModelContext) {
        self.context = context
        fetchBookmarks()
    }

    func fetchBookmarks() {
        guard let context else { return }
        do {
            // 1) 전체 북마크 먼저 가져오고
            let all = try context.fetch(
                FetchDescriptor<Bookmark>(
                    sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
                )
            )
            // 2) 카테고리 있으면 메모리에서 필터 
            if let category = category {
                self.bookmarks = all.filter { $0.food.category == category }
            } else {
                self.bookmarks = all
            }

            // 디버그
            #if DEBUG
            let counts = Dictionary(grouping: all, by: { $0.food.category })
                .mapValues(\.count)
            print("전체:\(all.count), 카테고리별:\(counts)")
            print("현재 카테고리:", category?.rawValue ?? "전체", "결과:", bookmarks.count)
            #endif
        } catch {
            print("북마크 불러오기 실패:", error)
        }
    }
}

