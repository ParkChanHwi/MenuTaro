//
//  OrangeButtonStyle.swift
//  MenuTaro
//
//  Created by mac mini on 10/24/25.
//

import SwiftUI

struct OrangeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { proxy in
            configuration.label
                .padding(.horizontal, proxy.size.width * 1 / 2.25)
                .padding(.vertical, proxy.size.height * 0.04)
                .foregroundColor(.white)
                .background(Color.primaryRed.opacity(configuration.isPressed ? 0.8 : 1), in: .rect)
                .cornerRadius(16)
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
    }
}

#Preview {
    OnboardingNameSettingView()
}
