//
//  PrimaryActionButton.swift
//  MenuTaro
//
//  Created by mac mini on 9/25/25.
//

import SwiftUI

public struct PrimaryActionButton: View {
    private let title: LocalizedStringKey
    private let action: () -> Void
    private let isDisabled: Bool
    private let isLoading: Bool
    private let fillWidth: Bool
    private let height: CGFloat
    private let cornerRadius: CGFloat
    private let backgroundColor: Color
    private let foregroundColor: Color
    
    public init(
        _ title: LocalizedStringKey,
        isDisabled: Bool = false,
        isLoading: Bool = false,
        fillWidth: Bool = false,
        height: CGFloat = 56,
        cornerRadius: CGFloat = 14,
        backgroundColor: Color = Color.buttonOrange,
        foregroundColor: Color = .white,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
        self.isDisabled = isDisabled
        self.isLoading = isLoading
        self.fillWidth = fillWidth
        self.height = height
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
    
    public var body: some View {
        Button(action: action) {
            ZStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .tint(foregroundColor)
                } else {
                    Text(title)
                        .font(.system(size: 20, weight: .bold, design: .default))
                    
                }
            }
            .frame(maxWidth:  fillWidth ? .infinity : nil , minHeight: height, maxHeight: height)
            
        }
        .background(backgroundColor.opacity(isDisabled ? 0.5 : 1.0))
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .animation(.easeInOut(duration: 0.15), value: isDisabled)
    }
}
