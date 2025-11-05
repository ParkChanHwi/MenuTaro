//
//  ProfileCharacterGrid.swift
//  MenuTaro
//
//  Created by mac mini on 11/5/25.
//


//
//  ProfileCharacterGrid.swift
//  MenuTaro
//
//  Created by mac mini on 11/5/25.
//


import SwiftUI

/// 공용 캐릭터 그리드 뷰 (LazyVGrid 래핑)
struct ProfileCharacterGrid: View {
    @ObservedObject var viewModel: OnboardingProfileCharacterViewModel

    // 레이아웃 파라미터
    var columnsCount: Int = 2
    var horizontalPaddingRatio: CGFloat = 0.10   // 화면 너비의 10%
    var gridSpacingRatio: CGFloat = 0.06         // 화면 너비의 6%

    var body: some View {
        GeometryReader { proxy in
            let horizontalPadding = proxy.size.width * horizontalPaddingRatio
            let gridSpacing = proxy.size.width * gridSpacingRatio
            let columns: [GridItem] = Array(
                repeating: GridItem(.flexible(), spacing: gridSpacing),
                count: columnsCount
            )
            let avatarDiameter = (proxy.size.width - (horizontalPadding * 2) - gridSpacing * CGFloat(columnsCount - 1))
            / CGFloat(columnsCount)

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
            .padding(.horizontal, horizontalPadding)
        }
        // 부모 뷰가 높이를 결정하도록 확장
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}