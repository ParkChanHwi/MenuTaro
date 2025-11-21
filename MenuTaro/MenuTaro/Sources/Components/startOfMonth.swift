//
//  startOfMonth.swift
//  MenuTaro
//
//  Created by 장현준 on 11/21/25.
//

import Foundation
// 이번달 시작일 설정임(매월 1일)/마이페이지 뷰, 랭킹 뷰에만 쓰임
extension Date {
    static var startOfThisMonth: Date {
        let now = Date()
        let cal = Calendar.current
        let comps = cal.dateComponents([.year, .month], from: now)
        return cal.date(from: comps) ?? now
    }
}
