// NotificationPermissionToggleView.swift
import SwiftUI
import UserNotifications

struct NotificationPermissionToggleView: View {
    @State private var isNotificationEnabled = false
    
    var body: some View {
        Toggle("앱 알림", isOn: $isNotificationEnabled)
            .toggleStyle(SwitchToggleStyle(tint: Color.primaryRed))
            .onChange(of: isNotificationEnabled) { newValue in
                if newValue {
                    self.requestOrNavigateToSettings()
                } else {
                    // 알림 허용안함 -> 설정으로
                    navigateToSeetings()
                    checkPermission()
                }
            }
        // 현재 알림 권한 상태 확인
            .onAppear {
                checkPermission()
            }
    }
    
    // 알림 권한 요청 팝업
    private func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            DispatchQueue.main.async {
                isNotificationEnabled = granted
                
                if granted {
                    NotificationManager.shared.scheduleDailyNotification()
                }
            }
        }
    }
    
    // 현재 알림 설정을 가져옴
    private func checkPermission() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                isNotificationEnabled = (settings.authorizationStatus == .authorized)
            }
        }
    }
    
    private func requestOrNavigateToSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                // 최초 요청
                case .notDetermined:
                    self.requestPermission()
                case .denied:
                    // 권한이 거부되어 있는 상태
                    self.navigateToSeetings()
                    isNotificationEnabled = false
                case .authorized, .provisional, .ephemeral:
                    // 이미 권한 있으면 토글 켜진 상태로 유지
                    isNotificationEnabled = true
                    NotificationManager.shared.scheduleDailyNotification()
                @unknown default:
                    isNotificationEnabled = false
                }
            }
        }
    }
    
    private func navigateToSeetings() {
        // 토글 누르면 설정으로 이동하게 안내
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url) { success in
                if !success {
                    print("Could not open settings")
                }
            }
        }
    }
}
