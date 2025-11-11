import Foundation

struct NotificationMessage {
    let title: String
    let body: String
}

// 알림 메시지 목록 데이터
let menuNotifications: [NotificationMessage] = [
    NotificationMessage(title: "오늘의 메뉴 추천", body: "한식"),
    NotificationMessage(title: "오늘의 메뉴 추천", body: "중식"),
    NotificationMessage(title: "오늘의 메뉴 추천", body: "양식"),
    NotificationMessage(title: "오늘의 메뉴 추천", body: "일식"),
    NotificationMessage(title: "오늘의 메뉴 추천", body: "분식")
]
