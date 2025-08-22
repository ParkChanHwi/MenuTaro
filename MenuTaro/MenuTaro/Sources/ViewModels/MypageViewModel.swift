//
//  MypageViewModel.swift
//  MenuTaro
//
//  Created by 장현준 on 8/22/25.
//

import SwiftUI
import SwiftData

@MainActor
final class MypageViewModel: ObservableObject {
    private var context: ModelContext?
    @Published var menuTop3: [Mypage] = []

    init() {}

    func setContext(_ context: ModelContext) {
        self.context = context
        fetchMenuTop3()
    }
    
    func fetchMenuTop3(limit: Int = 10, for user: User? = nil) {
        guard let context else { return }
        do {
            var desc = FetchDescriptor<Mypage>(
                sortBy: [
                    SortDescriptor(\.rank, order: .forward),
                    SortDescriptor(\.createdAt, order: .reverse)
                ]
            )

            if let u = user {
                        let uid = u.userId
                        desc.predicate = #Predicate<Mypage> { mp in
                            mp.user.userId == uid
                        }
                    }

            let rows = try context.fetch(desc)
            menuTop3 = Array(rows.prefix(limit))
        } catch {
            print("메뉴 랭킹 불러오기 실패:", error)
        }
    }

    func refresh(for user: User? = nil) {
        fetchMenuTop3(for: user)
    }
}
