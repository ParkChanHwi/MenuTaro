import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let center = UNUserNotificationCenter.current()
        center.delegate = self

        let notificationManager = NotificationManager.shared

        notificationManager.fetchAuthorizationStatus { status in
            switch status {
            case .authorized, .provisional:
                print("[AppDelegate] 기존 권한으로 알림 스케줄링 시작")
                notificationManager.scheduleDailyNotification()

            case .notDetermined:
                print("[AppDelegate] 권한 미확인 상태, 요청 진행")
                notificationManager.requestNotificatonAuthorization { granted in
                    print("[AppDelegate] 권한 요청 결과: \(granted)")
                    if granted {
                        notificationManager.scheduleDailyNotification()
                    }
                }

            default:
                print("[AppDelegate] 알림 권한 거부 상태")
            }
        }

        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: "Default Coniguration", sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .badge, .banner])
    }
}
