//
//  AppFont.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/14/25.
//

import SwiftUI

struct AppFont: ViewModifier {
    var size: CGFloat
    var weight: Font.Weight
    
    func body(content: Content) -> some View {
        content.font(.system(size: size, weight: weight))
    }
}

extension View {
    func appFont(_ size: CGFloat, weight: Font.Weight = .regular) -> some View {
        self.modifier(AppFont(size: size, weight: weight))
    }
}


/* 사용 예
 Text("Regular Text").appFont(17) // 기본 Regular
 Text("Bold Text").appFont(20, weight: .bold)
 Text("SemiBold Text").appFont(18, weight: .semibold)
 Text("Light Text").appFont(16, weight: .light)
 */
