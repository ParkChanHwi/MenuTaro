//
//  OnboardingTermsViewModel.swift
//  MenuTaro
//
//  Created by mac mini on 10/29/25.
//

import SwiftUI

enum TermsDocument: Hashable {
    case serviceTerms
    case privacyPolicy
    case marketingConsent

    var title: String {
        switch self {
        case .serviceTerms:
            return "앱 기본 이용약관"
        case .privacyPolicy:
            return "개인정보 처리방침"
        case .marketingConsent:
            return "마케팅 정보 수신 동의"
        }
    }

    var chapters: [TermsChapter] {
        switch self {
        case .serviceTerms:
            return TermsChapter.Terms_Ko
        case .privacyPolicy:
            return TermsChapter.privacyPolicyKo
        case .marketingConsent:
            return TermsChapter.marketingConsentKo
        }
    }
}


struct ConsentItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let isRequired: Bool
    let document: TermsDocument
    var isOn: Bool = false
}

@MainActor
final class OnboardingTermsViewModel: ObservableObject {
    @Published var items: [ConsentItem] = [
        .init(title: "[필수] 서비스 이용약관 동의", isRequired: true, document: .serviceTerms, isOn: false),
        .init(title: "[필수] 개인정보 처리방침 동의", isRequired: true, document: .privacyPolicy, isOn: false),
       // .init(title: "[선택] 마케팅 정보 수신 동의", isRequired: false, document: .marketingConsent, isOn: false)
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
