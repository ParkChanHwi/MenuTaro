//
//  MypageEditView.swift
//  MenuTaro
//
//  Created by mac mini on 11/5/25.
//

import SwiftUI

struct MypageEditView: View {
    @State private var name: String = ""
    @StateObject private var viewModel = OnboardingProfileCharacterViewModel()

    var body: some View {
        GeometryReader { proxy in
            let metrics = MenuTaroLayoutMetrics.metrics(for: proxy.size)

            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("닉네임")
                        .font(.system(.title, weight: .bold))
                        .padding(.leading, proxy.size.width * 0.08)
                        .foregroundColor(.white)

                    PillTextField(text: $name)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 32)

                    Text("*닉네임은 한글, 영문, 숫자(2~10)자 이내로 작성해주세요!")
                        .foregroundColor(.primaryRed)
                        .font(.system(.caption, weight: .medium))
                        .padding(.leading, proxy.size.width * 0.1)

                    Text("프로필 캐릭터")
                        .font(.system(.title, weight: .bold))
                        .padding(.top, proxy.size.height * 0.03)
                        .padding(.leading, proxy.size.width * 0.08)
                        .foregroundColor(.white)

                   
                    ProfileCharacterGrid(viewModel: viewModel)
                        .frame(minHeight: proxy.size.height * 0.35)
                        .padding(.bottom, metrics.callToActionHeight + metrics.orangeButtonBottomInset)
                }
                
                Button("다음") {

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
    MypageEditView()
}
