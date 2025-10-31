//
//  ProfileCharacterAvatar.swift
//  MenuTaro
//
//  Created by mac mini on 10/27/25.
//


import SwiftUI

struct ProfileCharacterAvatar: View {
    static let defaultSelectedBackground = LinearGradient(
        colors: [
            Color(red: 33 / 255, green: 33 / 255, blue: 33 / 255),
            Color(red: 255 / 255, green: 73 / 255, blue: 35 / 255)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    static let defaultUnselectedBackground = Color.buttonGrey

    private let imageName: String
    private let diameter: CGFloat
    private let imageScale: CGFloat
    private let backgroundStyle: AnyShapeStyle

    init(
        imageName: String,
        diameter: CGFloat,
        backgroundStyle: some ShapeStyle,
        imageScale: CGFloat = MenuTaroLayoutMetrics.profileImageScale
    ) {
        self.imageName = imageName
        self.diameter = diameter
        self.backgroundStyle = AnyShapeStyle(backgroundStyle)
        self.imageScale = imageScale
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(backgroundStyle)
                .frame(width: diameter, height: diameter)

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: diameter * imageScale, height: diameter * imageScale)
                .clipShape(Circle())
        }
        .frame(width: diameter, height: diameter)
    }
}

#Preview {
    ProfileCharacterAvatar(
        imageName: "chicken",
        diameter: 200,
        backgroundStyle: ProfileCharacterAvatar.defaultSelectedBackground
    )
}