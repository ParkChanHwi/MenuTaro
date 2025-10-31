//
//  OrangeButtonStyle.swift
//  MenuTaro
//
//  Created by mac mini on 10/24/25.
//

import SwiftUI

struct OrangeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.primaryRed.opacity(configuration.isPressed ? 0.8 : 1))
                )
                .scaleEffect(configuration.isPressed ? 0.96 : 1)
                .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

#Preview {
    OnboardingNameSettingView()
}
