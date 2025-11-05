//
//  OnboardingProfileCharacter.swift
//  MenuTaro
//
//  Created by mac mini on 10/27/25.
//  온보딩 - 2 프로필 캐릭터 선택

import SwiftUI

struct OnboardingProfileCharacter: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var onboarding: OnboardingFlowViewModel

    private var isNextEnabled: Bool {
        onboarding.selectedCharacter != nil
    }

    var body: some View {
        GeometryReader { proxy in
            let metrics = MenuTaroLayoutMetrics.metrics(for: proxy.size)

            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("2/3")
                        .font(.system(.subheadline, weight: .bold))
                        .foregroundColor(.primaryRed)
                        .padding(.horizontal, metrics.horizontalPadding)

                    Text("프로필 캐릭터를\n선택해주세요.")
                        .font(.system(.title, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, metrics.horizontalPadding)

                    Text("*캐릭터는 언제든지 바꿀 수 있어요!")
                        .font(.system(.caption, weight: .regular))
                        .foregroundColor(.white)
                        .padding(.horizontal, metrics.horizontalPadding)

                    ProfileCharacterGrid(viewModel: onboarding.characterSelection)
                        .frame(minHeight: proxy.size.height * 0.35)
                        .padding(.bottom, metrics.callToActionHeight + metrics.orangeButtonBottomInset)
                        .padding(.top)
                }



                Button("다음") {
                    router.push(.onboarding(step: .terms))
                }
                .appFont(20, weight: .bold)
                .frame(height: metrics.callToActionHeight)
                .buttonStyle(OrangeButtonStyle())
                .padding(.horizontal, metrics.horizontalPadding)
                .padding(.bottom, metrics.orangeButtonBottomInset)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .disabled(!isNextEnabled)
                .opacity(isNextEnabled ? 1 : 0.5)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .background(Color.black)
    }
}

#Preview {
    OnboardingProfileCharacter()
        .environmentObject(Router())
        .environmentObject(OnboardingFlowViewModel())
}
