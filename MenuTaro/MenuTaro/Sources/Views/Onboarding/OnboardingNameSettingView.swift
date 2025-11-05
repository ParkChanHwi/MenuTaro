//
//  OnboardingNameSettingView.swift
//  MenuTaro
//
//  Created by mac mini on 10/23/25.
//  온보딩 - 1 닉네임 설정

import SwiftUI

struct OnboardingNameSettingView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var onboarding: OnboardingFlowViewModel

    private var isNextEnabled: Bool {
        onboarding.isNameValid
    }


    var body: some View {
        GeometryReader { proxy in
            let metrics = MenuTaroLayoutMetrics.metrics(for: proxy.size)

            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("1/3")
                        .font(.system(.subheadline, weight: .bold))
                        .foregroundColor(.primaryRed)
                        .padding(.leading, proxy.size.width * 0.1)
                    Text("반가워요! 사용하실\n이름을 알려주세요.")
                        .font(.system(.title, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.leading, proxy.size.width * 0.1)
                    Text("*닉네임은 언제든지 바꿀 수 있어요!\n*닉네임은 한글, 영문, 숫자 (2~10자)이내로 작성해주세요!")
                        .font(.system(.caption, weight: .regular))
                        .foregroundColor(.white)
                        .padding(.leading, proxy.size.width * 0.1)

                    PillTextField(text: $onboarding.nickname)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 32)
                }
                .padding(.bottom, metrics.callToActionHeight + metrics.orangeButtonBottomInset)

                Button("다음") {
                    router.push(.onboarding(step: .profile))
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
    OnboardingNameSettingView()
        .environmentObject(Router())
        .environmentObject(OnboardingFlowViewModel())
}
