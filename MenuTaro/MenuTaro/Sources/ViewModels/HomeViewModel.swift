//
//  HomeViewModel.swift
//  MenuTaro
//
//  Created by 장현준 on 11/13/25.
//

import SwiftUI
import SwiftData

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var recentFoods: [FoodCard] = []

    private var context: ModelContext?

    // 인사말 텍스트는 상태(currentUser)에 따라 자동 계산
    var greetingText: String {
        if let nickname = currentUser?.nickname, !nickname.isEmpty {
            return "안녕, \(nickname)!\n오늘은 뭘\n먹어볼까?"
        } else {
            return "안녕!\n오늘은 뭘\n먹어볼까?"
        }
    }

    // 컨텍스트 주입

    func setContext(_ context: ModelContext) {
        self.context = context
        reload()
    }

    func reload() {
        loadCurrentUser()
        loadRecentFoods()
    }

    // 개별 로딩 함수

    private func loadCurrentUser() {
        guard let context else { return }

        var descriptor = FetchDescriptor<User>()
        descriptor.fetchLimit = 1

        do {
            let users = try context.fetch(descriptor)
            currentUser = users.first
        } catch {
            print("HomeViewModel - 사용자 로드 실패:", error)
            currentUser = nil
        }
    }

    private func loadRecentFoods() {
        guard let context else { return }

        var desc = FetchDescriptor<ConsumptionRecord>(
            sortBy: [SortDescriptor(\.timestamp, order: .reverse)]
        )
        desc.fetchLimit = 20
        desc.predicate = #Predicate { $0.food != nil }

        do {
            let records = try context.fetch(desc)

            var seen = Set<UUID>()
            var items: [FoodCard] = []

            for record in records {
                guard let food = record.food else { continue }
                if seen.insert(food.foodId).inserted {
                    items.append(food)
                }
                if items.count >= 10 { break }
            }

            recentFoods = items
        } catch {
            print("HomeViewModel - 최근 음식 로드 실패:", error)
            recentFoods = []
        }
    }
}
