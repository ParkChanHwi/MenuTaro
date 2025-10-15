//
//  BackgroundStylePreference.swift
//  MenuTaro
//
//  Created by mac mini on 10/1/25.
//

import SwiftUI

struct BackgroundStylePreferenceKey: PreferenceKey {
    static var defaultValue: AppBackgroundView.Style = .black
    static func reduce(value: inout AppBackgroundView.Style, nextValue: () -> AppBackgroundView.Style) {
        value = nextValue() // 여러 값이 들어왔을 때 마지막 값에 우선순위를 줌
    }
}

extension View {
    func appBackgroundStyle(_ style: AppBackgroundView.Style) -> some View {
        preference(key: BackgroundStylePreferenceKey.self, value: style)
    }
    
}
