import SwiftUI
import SwiftData

@main
struct MenuTaroAppApp: App {
    @AppStorage("hasOnboarded") var hasOnboarded = false // 온보딩 표시 여부, 온보딩을 안봤으면 앱 초기 실행이므로 프로필 설정도 해줘야함
    var body: some Scene {
        WindowGroup {
            SnackTaro()
                .modelContainer(for: [User.self, Snack.self, FoodCard.self, ConsumptionRecord.self, Bookmark.self])
                .preferredColorScheme(.dark)
        }
    }
}
