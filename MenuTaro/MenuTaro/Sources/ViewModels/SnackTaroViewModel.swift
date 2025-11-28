//
//  SnackFortuneViewModel.swift
//  MenuTaro
//
//  Created by mac mini on 11/27/25.
//


import Foundation
import SwiftData

@MainActor
final class SnackTaroViewModel: ObservableObject {
    @Published private(set) var selectedSnack: Snack?

    private var modelContext: ModelContext?
    private var currentUser: User?
    private var hasLoggedConsumption = false

    func setContext(_ context: ModelContext) {
        guard modelContext !== context else { return }
        modelContext = context
        if currentUser == nil {
            _ = loadCurrentUser()
        }
    }

    func startNewFortune() {
        selectedSnack = nil
        hasLoggedConsumption = false
    }

    func ensureRandomSnackSelected() {
        guard selectedSnack == nil else { return }
        selectRandomSnack()
    }

    func selectRandomSnack() {
        guard let context = modelContext else { return }

        do {
            let snacks = try context.fetch(FetchDescriptor<Snack>())
            guard !snacks.isEmpty else {
                selectedSnack = nil
                return
            }

            selectedSnack = snacks.randomElement()
            hasLoggedConsumption = false
        } catch {
            print("Failed to fetch snacks: \(error.localizedDescription)")
            selectedSnack = nil
        }
    }

    func logConsumptionIfNeeded() {
        guard !hasLoggedConsumption,
              let snack = selectedSnack,
              let context = modelContext else { return }

        guard let user = currentUser ?? loadCurrentUser() else { return }

        let record = ConsumptionRecord(
            recordId: UUID(),
            timestamp: Date(),
            food: nil,
            snack: snack,
            user: user
        )

        context.insert(record)

        do {
            try context.save()
            hasLoggedConsumption = true
        } catch {
            context.delete(record)
            print("Snack consumption save failed: \(error.localizedDescription)")
        }
    }

    @discardableResult
    private func loadCurrentUser() -> User? {
        guard let context = modelContext else {
            currentUser = nil
            return nil
        }

        var descriptor = FetchDescriptor<User>()
        descriptor.fetchLimit = 1

        do {
            let users = try context.fetch(descriptor)
            currentUser = users.first
        } catch {
            print("Failed to load current user: \(error.localizedDescription)")
            currentUser = nil
        }

        return currentUser
    }
}
