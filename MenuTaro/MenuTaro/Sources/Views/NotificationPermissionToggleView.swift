import SwiftUI
import UserNotifications

struct NotificationPermissionToggleView: View {
    @State private var isNotificationEnabled = false
    
    var body: some View {
        Toggle("앱 알림", isOn: $isNotificationEnabled)
            .toggleStyle(SwitchToggleStyle(tint: Color.primaryRed))
            .onChange(of: isNotificationEnabled) { newValue in
                if newValue {
                    
                } else {
                    isNotificationEnabled = false
                }
            }
            .onAppear {
                checkPermission()
            }
    }
    
    private func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            DispatchQueue.main.async {
                isNotificationEnabled = granted
            }
        }
    }
    
    private func checkPermission() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                isNotificationEnabled = (settings.authorizationStatus == .authorized)
            }
        }
    }
}
