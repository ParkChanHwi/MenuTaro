import SwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let rootView = NavigationRootView()
            .environmentObject(Router())
            .modelContainer(for: [User.self, Snack.self, FoodCard.self, ConsumptionRecord.self, Bookmark.self])
        
        window.rootViewController = UIHostingController(rootView: rootView)
        self.window = window
        window.makeKeyAndVisible()
        
        sendNotificationMessage()
    }
    
    func sendNotificationMessage() {
        guard let randomMessage = menuNotifications.randomElement() else {
            print("알림 메시지 목록이 비어있습니다.")
            return
        }
        
        let content = UNMutableNotificationContent()
        
        content.title = randomMessage.title
        content.body = randomMessage.body
        content.sound = .default
        
        // 실행 후 3초 후 알림
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("알림 등록 실패: \(error.localizedDescription)")
            } else {
                print("알림 등록 완료")
            }
        }
    }
}
