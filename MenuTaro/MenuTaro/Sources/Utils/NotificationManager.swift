import SwiftUI
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    func requestNotificatonAuthorization() {
        // 알림 권한 요청 (알림, 소리, 배지)
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error {
                print("알림 권한 요청 오류: \(error)")
            } else if success {
                print("사용자가 알림 권한 허용")
            } else {
                print("사용자가 알림 권한 거부")
            }
        }
    }
}
