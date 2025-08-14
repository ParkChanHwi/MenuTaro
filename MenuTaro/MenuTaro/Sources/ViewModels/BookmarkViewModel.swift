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
    
    init() {}
    
    func setContext(_ context: ModelContext) {
        self.context = context
        fetchBookmarks()
    }
    
    func fetchBookmarks() {
        guard let context else { return }
        do {
            let descriptor = FetchDescriptor<Bookmark>(
                sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
            )
            bookmarks = try context.fetch(descriptor)
        } catch {
            print("북마크 불러오기 실패:", error)
        }
    }
}
