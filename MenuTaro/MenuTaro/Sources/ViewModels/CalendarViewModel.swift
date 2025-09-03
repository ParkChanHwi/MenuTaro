//
//  CalendarViewModel.swift
//  MenuTaro
//
//  Created by 장현준 on 9/2/25.
//

import Foundation
import SwiftData

struct TimelineSimpleItem: Identifiable {
    let id: UUID
    let title: String
    let category: String?
    let slotLabel: String
    let image: String
}

@MainActor
final class CalendarViewModel: ObservableObject {

    @Published private(set) var timelineItems: [TimelineSimpleItem] = []
    
    func reload(for date: Date, context: ModelContext) {
            let dayStart = Calendar.current.startOfDay(for: date)
            guard let dayEnd = Calendar.current.date(byAdding: .day, value: 1, to: dayStart) else { return }

            do {
                let desc = FetchDescriptor<ConsumptionRecord>(
                    predicate: #Predicate { rec in
                        rec.timestamp >= dayStart && rec.timestamp < dayEnd
                    },
                    sortBy: [SortDescriptor(\.timestamp, order: .forward)]
                )
                let records = try context.fetch(desc)
                updateTimeline(with: records)
            } catch {
                print("해당 날짜 레코드 로드 실패:", error)
                updateTimeline(with: [])
            }
        }
    
    func updateTimeline(with records: [ConsumptionRecord]) {
        timelineItems = makeTimelineItems(from: records)
    }

    private func makeTimelineItems(from records: [ConsumptionRecord]) -> [TimelineSimpleItem] {
        let sorted = records.sorted {
            if $0.timestamp == $1.timestamp {
                return $0.recordId.uuidString < $1.recordId.uuidString
            }
            return $0.timestamp < $1.timestamp
        }

        var mealCount = 0
        var result: [TimelineSimpleItem] = []
        result.reserveCapacity(sorted.count)

        for record in sorted {
            if let food = record.food {
                mealCount += 1
                result.append(
                    TimelineSimpleItem(
                        id: record.recordId,
                        title: food.name,
                        category: food.category.rawValue,
                        slotLabel: "\(ordinalLabel(mealCount)) 끼니",
                        image: safeImage(food.image)
                    )
                )
            } else if let snack = record.snack {
                result.append(
                    TimelineSimpleItem(
                        id: record.recordId,
                        title: snack.name,
                        category: nil,
                        slotLabel: "간식",
                        image: safeImage(snack.image)
                    )
                )
            }
        }

        return result
    }
    private func safeImage(_ name: String) -> String {
            name.isEmpty ? "placeholder_food" : name
        }

    private func ordinalLabel(_ n: Int) -> String {
        switch n {
        case 1: return "첫"
        case 2: return "두"
        case 3: return "세"
        case 4: return "네"
        default: return "\(n)번째"
        }
    }
}
