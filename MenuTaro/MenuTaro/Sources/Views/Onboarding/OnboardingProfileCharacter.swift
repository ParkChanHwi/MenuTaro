//
//  OnboardingProfileCharacter.swift
//  MenuTaro
//
//  Created by mac mini on 10/27/25.
//  온보딩 - 2 프로필 캐릭터 선택

import SwiftUI

struct OnboardingProfileCharacter: View {
    @StateObject private var viewModel = OnboardingProfileCharacterViewModel()

    var body: some View {
        GeometryReader { proxy in
            let metrics = MenuTaroLayoutMetrics.metrics(for: proxy.size)
            let horizontalPadding = proxy.size.width * 0.1
            let gridSpacing = proxy.size.width * 0.06
            let columns: [GridItem] = Array(
                repeating: GridItem(.flexible(), spacing: gridSpacing),
                count: 2
            )
            let avatarDiameter = (proxy.size.width - (horizontalPadding * 2) - gridSpacing) / 2

            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("2/3")
                        .font(.system(.subheadline, weight: .bold))
                        .foregroundColor(.primaryRed)

                    Text("프로필 캐릭터를\n선택해주세요.")
                        .font(.system(.title, weight: .bold))
                        .foregroundColor(.white)

                    Text("*캐릭터는 언제든지 바꿀 수 있어요!")
                        .font(.system(.caption, weight: .regular))
                        .foregroundColor(.white)

                    LazyVGrid(columns: columns, alignment: .center, spacing: gridSpacing) {
                        ForEach(viewModel.characters, id: \.self) { character in
                            let backgroundStyle = viewModel.backgroundStyle(for: character)

                            Button {
                                viewModel.toggleSelection(for: character)
                            } label: {
                                ProfileCharacterAvatar(
                                    imageName: character,
                                    diameter: avatarDiameter,
                                    backgroundStyle: backgroundStyle
                                )
                                .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, horizontalPadding)
                .padding(.bottom, metrics.callToActionHeight + metrics.orangeButtonBottomInset)

                Button("다음") {

                }
                .appFont(20, weight: .bold)
                .frame(height: metrics.callToActionHeight)
                .buttonStyle(OrangeButtonStyle())
                .padding(.horizontal, metrics.horizontalPadding)
                .padding(.bottom, metrics.orangeButtonBottomInset)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .background(Color.black)
    }
}

#Preview {
    OnboardingProfileCharacter()
}
