// NotificationPermissionToggleView.swift
import SwiftUI
import UserNotifications

struct NotificationPermissionToggleView: View {
    private let notificationManager = NotificationManager.shared
    @State private var isNotificationEnabled = false

    var body: some View {
        Toggle("앱 알림", isOn: $isNotificationEnabled)
            .toggleStyle(SwitchToggleStyle(tint: Color.primaryRed))
            .onChange(of: isNotificationEnabled) { newValue in
                if newValue {
                    self.requestOrNavigateToSettings()
                } else {
                    notificationManager.removeDailyNotifications()
                    // 알림 허용안함 -> 설정으로
                    navigateToSeetings()
                }
            }
        // 현재 알림 권한 상태 확인
            .onAppear {
                checkPermission()
            }
    }

    // 알림 권한 요청 팝업
    private func requestPermission() {
        notificationManager.requestNotificatonAuthorization { granted in
            isNotificationEnabled = granted

            if granted {
                notificationManager.scheduleDailyNotification()
            } else {
                notificationManager.removeDailyNotifications()
            }
        }
    }

    // 현재 알림 설정을 가져옴
    private func checkPermission() {
        notificationManager.fetchAuthorizationStatus { status in
            switch status {
            case .authorized, .provisional:
                isNotificationEnabled = true
            default:
                isNotificationEnabled = false
            }
        }
    }
    
    private func requestOrNavigateToSettings() {
        notificationManager.fetchAuthorizationStatus { status in
            switch status {
            case .notDetermined:
                self.requestPermission()
            case .denied:
                // 권한이 거부되어 있는 상태
                self.navigateToSeetings()
                isNotificationEnabled = false
            case .authorized, .provisional, .ephemeral:
                // 이미 권한 있으면 토글 켜진 상태로 유지
                isNotificationEnabled = true
                notificationManager.scheduleDailyNotification()
            @unknown default:
                isNotificationEnabled = false
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
