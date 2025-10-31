//
//  OnboardingTermsView.swift
//  MenuTaro
//
//  Created by mac mini on 10/29/25.
//

import SwiftUI

struct OnboardingTermsView: View {
    @StateObject private var vm = OnboardingTermsViewModel()

    var body: some View {
        GeometryReader { proxy in
            let metrics = MenuTaroLayoutMetrics.metrics(for: proxy.size)
            
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("3/3")
                        .font(.system(.subheadline, weight: .bold))
                        .foregroundColor(.primaryRed)
                        .padding(.leading, proxy.size.width * 0.1)

                    Text("주의 사항을\n확인해주세요.")
                        .font(.system(.title, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.leading, proxy.size.width * 0.1)

                    Text("*앱을 지우면 기록이 사라지니 주의해주세요!")
                        .font(.system(.caption, weight: .regular))
                        .foregroundColor(.white)
                        .padding(.leading, proxy.size.width * 0.1)


                 
                    VStack(spacing: 6) {
                        ForEach(vm.items) { item in
                            ConsentRow(
                                item: item,
                                toggle: { vm.toggle(item) },
                                showDetail: { vm.showDetail(for: item) }
                            )
                        }
                    }
                    .padding(.horizontal, metrics.horizontalPadding)
                    .padding(.top, metrics.componentSpacing + proxy.size.height * 0.4)

                    .padding(.bottom, metrics.callToActionHeight + metrics.orangeButtonBottomInset)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // 하단 CTA (그대로 유지)
                Button("시작하기") {
                    // action
                }
                .appFont(20, weight: .bold)
                .frame(height: metrics.callToActionHeight)
                .buttonStyle(OrangeButtonStyle())
                .padding(.horizontal, metrics.horizontalPadding)
                .padding(.bottom, metrics.orangeButtonBottomInset)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
        }
        .background(Color.black)
    }
}


#Preview {
    OnboardingTermsView()
}
