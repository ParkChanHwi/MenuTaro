//
//  MenuTaroLayoutMetrics.swift
//  MenuTaro
//
//  Created by mac mini on 10/27/25.
//


import SwiftUI

struct MenuTaroLayoutMetrics {
    static let profileImageScale: CGFloat = 0.996
    let cardWidth: CGFloat
    let cardAspectRatio: CGFloat
    let componentSpacing: CGFloat
    let bookmarkPillSize: CGSize
    let bookmarkFontSize: CGFloat
    let callToActionHeight: CGFloat
    let callToActionFontSize: CGFloat
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat
    let bottomSpacer: CGFloat
    let orangeButtonBottomInset: CGFloat

    static func metrics(for size: CGSize) -> MenuTaroLayoutMetrics {
        let width = size.width
        let height = size.height

        let cardWidth = min(width * 0.78, 360)
        let spacing = max(16, width * 0.06)
        let pillHeight = max(41, width * 0.11)
        let pillWidth = min(width * 0.56, 220)
        let ctaHeight = max(56, width * 0.14)
        let horizontalPadding = max(20, width * 0.08)
        let verticalPadding = max(16, height * 0.04)
        let bottomSpacer = height * 0.06

        return MenuTaroLayoutMetrics(
            cardWidth: cardWidth,
            cardAspectRatio: 0.62,
            componentSpacing: spacing,
            bookmarkPillSize: CGSize(width: pillWidth, height: pillHeight),
            bookmarkFontSize: max(14, width * 0.04),
            callToActionHeight: ctaHeight,
            callToActionFontSize: max(16, width * 0.045),
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding,
            bottomSpacer: bottomSpacer,
            orangeButtonBottomInset: verticalPadding
        )
    }
}
