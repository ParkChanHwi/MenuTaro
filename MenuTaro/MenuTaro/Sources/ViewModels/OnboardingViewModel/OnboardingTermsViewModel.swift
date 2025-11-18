//
//  OnboardingTermsViewModel.swift
//  MenuTaro
//
//  Created by mac mini on 10/29/25.
//

import SwiftUI

struct ConsentItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let isRequired: Bool
    var isOn: Bool = false
}

@MainActor
final class OnboardingTermsViewModel: ObservableObject {
    @Published var items: [ConsentItem] = [
        .init(title: "[필수] 개인정보 수집 항목 동의", isRequired: true,  isOn: false),
        .init(title: "[선택] 마케팅 정보 수신 동의", isRequired: false, isOn: false)
    ]
    @Published var detailItem: ConsentItem?
    
    var canStart: Bool {
        items.filter(\.isRequired).allSatisfy(\.isOn)
    }
    
    func toggle(_ item: ConsentItem) {
        guard let idx = items.firstIndex(of: item) else { return }
        items[idx].isOn.toggle()
    }
    
    /// 상세 약관 화면 이동
    func showDetail(for item: ConsentItem) {
        detailItem = item
    }
    
    func dismissDetail() {
        detailItem = nil
    }
}
