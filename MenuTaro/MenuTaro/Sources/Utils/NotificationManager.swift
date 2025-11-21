// NotificationManager.swift
import SwiftUI
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    private let notificationCenter = UNUserNotificationCenter.current()
    private lazy var logDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = .current
        return formatter
    }()

    private let dailyNotificationIdentifiers = [
        "morning_notification",
        "lunch_notification",
        "dinner_notification"
    ]

    func requestNotificatonAuthorization(completion: @escaping (Bool) -> Void) {
        // 알림 권한 요청 (알림, 소리, 배지)
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]

        notificationCenter.requestAuthorization(options: options) { success, error in
            if let error {
                print("알림 권한 요청 오류: \(error)")
            } else if success {
                print("사용자가 알림 권한 허용")
            } else {
                print("사용자가 알림 권한 거부")
            }

            DispatchQueue.main.async {
                completion(success)
            }
        }
    }

    func fetchAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        notificationCenter.getNotificationSettings { settings in
            print("현재 알림 권한 상태: \(settings.authorizationStatus.rawValue)")
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }

    func scheduleDailyNotification() {
        notificationCenter.getNotificationSettings { [weak self] settings in
            guard let self else { return }

            guard settings.authorizationStatus == .authorized || settings.authorizationStatus == .provisional else {
                print("알림 권한이 없어 스케줄링하지 않음")
                return
            }

            print("일일 알림 스케줄링 시작")

            let times: [(identifier: String, hour: Int, minute: Int, title: String, body: String)] = [
                (self.dailyNotificationIdentifiers[0], 8, 0, "아침 알림", "아침 드세요!"),
                (self.dailyNotificationIdentifiers[1], 12, 0, "점실 알림", "점심 드세요!"),
                (self.dailyNotificationIdentifiers[2], 18, 0, "저녁 알림", "저녁 드세요!")
            ]

            self.notificationCenter.removePendingNotificationRequests(withIdentifiers: self.dailyNotificationIdentifiers)
            print("기존 일일 알림 제거: \(self.dailyNotificationIdentifiers)")
            self.logPendingNotifications(context: "after removePendingNotificationRequests")

            for time in times {
                self.scheduleNotification(
                    identifier: time.identifier,
                    hour: time.hour,
                    minute: time.minute,
                    title: time.title,
                    body: time.body
                )
            }

            self.logPendingNotifications(context: "after scheduleDailyNotification")
        }
    }

    func removeDailyNotifications() {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: dailyNotificationIdentifiers)
    }

    private func scheduleNotification(
        identifier: String,
        hour: Int,
        minute: Int,
        title: String,
        body: String
    ) {
        print("알림 예약 시도: identifier=\(identifier), 시간=\(String(format: "%02d:%02d", hour, minute))")

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.timeZone = .current
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )
        notificationCenter.add(request) { error in
            if let error {
                print("알림 예약 실패: \(error.localizedDescription)")
            } else {
                let nextDate = (trigger as? UNCalendarNotificationTrigger)?.nextTriggerDate()
                let formattedDate = nextDate.map { self.logDateFormatter.string(from: $0) } ?? "unknown"
                print("알림 예약 완료: identifier=\(identifier), 다음 트리거=\(formattedDate)")
            }
        }
    }

    private func logPendingNotifications(context: String) {
        notificationCenter.getPendingNotificationRequests { [weak self] requests in
            guard let self else { return }

            print("[알림 로그][\(context)] 대기 중 알림 개수: \(requests.count)")

            for request in requests {
                let triggerDescription = self.describe(trigger: request.trigger)
                print("- identifier=\(request.identifier), trigger=\(triggerDescription)")
            }
        }
    }

    private func describe(trigger: UNNotificationTrigger?) -> String {
        guard let trigger else { return "없음" }

        if let calendarTrigger = trigger as? UNCalendarNotificationTrigger {
            let hour = calendarTrigger.dateComponents.hour ?? -1
            let minute = calendarTrigger.dateComponents.minute ?? -1
            let nextDate = calendarTrigger.nextTriggerDate().map { logDateFormatter.string(from: $0) } ?? "알 수 없음"
            return "캘린더 트리거 (시간=\(String(format: "%02d:%02d", hour, minute)), 다음 트리거=\(nextDate))"
        }

        return String(describing: type(of: trigger))
    }
}
