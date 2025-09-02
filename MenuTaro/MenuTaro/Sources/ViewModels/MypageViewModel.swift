//
//  MypageViewModel.swift
//  MenuTaro
//
//  Created by 장현준 on 8/22/25.
//

import SwiftUI
import SwiftData

struct FoodRank: Identifiable, Hashable {
    let id: UUID
    let food: FoodCard
    let count: Int
}

struct SnackRank: Identifiable, Hashable {
    let id: UUID
    let snack: Snack
    let count: Int
}

@MainActor
final class MypageViewModel: ObservableObject {
    private var context: ModelContext?
    @Published var menuTop3: [FoodRank] = []
    @Published var snackTop3: [SnackRank] = []

    init() {}

    func setContext(_ context: ModelContext) {
        self.context = context
        fetchMenuTop3()
        fetchSnackTop3()
    }
    
    func fetchMenuTop3(limit: Int = 10, for user: User? = nil) {
        guard let context else { return }
        do {
            var desc = FetchDescriptor<ConsumptionRecord>()
            
            if let u = user {
                let uid = u.userId
                desc.predicate = #Predicate { $0.user.userId == uid }
            }
            
            let records = try context.fetch(desc)
            let foods = records.compactMap { $0.food }
            let grouped = Dictionary(grouping: foods, by: { $0 })
            let ranks = grouped.map { (food, arr) in
                FoodRank(id: food.foodId, food: food, count: arr.count)
            }
            menuTop3 = Array(ranks.sorted { $0.count > $1.count }.prefix(limit))
        } catch {
            print("메뉴 랭킹 불러오기 실패:", error)
        }
    }
    
    func fetchSnackTop3(limit: Int = 3, for user: User? = nil) {
            guard let context else { return }
            do {
                var desc = FetchDescriptor<ConsumptionRecord>()
                
                if let u = user {
                    let uid = u.userId
                    desc.predicate = #Predicate { $0.user.userId == uid }
                }
                
                let records = try context.fetch(desc)
                let snacks = records.compactMap { $0.snack }
                let grouped = Dictionary(grouping: snacks, by: { $0 })
                let ranks = grouped.map { (snack, arr) in
                    SnackRank(id: snack.snackId, snack: snack, count: arr.count)
                }
                
                snackTop3 = Array(ranks.sorted { $0.count > $1.count }.prefix(limit))
                
            } catch {
                print("간식 랭킹 불러오기 실패:", error)
            }
        }

    func refresh(for user: User? = nil) {
        fetchMenuTop3(for: user)
        fetchSnackTop3(for: user)
    }
}
