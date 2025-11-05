import SwiftUI
import SwiftData

@main
struct MenuTaroAppApp: App {
    @StateObject private var router = Router()
    var body: some Scene {
        WindowGroup {
            NavigationRootView()
                .environmentObject(router)
                .modelContainer(for: [User.self, Snack.self, FoodCard.self, ConsumptionRecord.self, Bookmark.self])
        }
    }
}
