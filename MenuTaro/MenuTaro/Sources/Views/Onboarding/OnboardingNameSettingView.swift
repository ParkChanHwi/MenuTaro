//
//  OnboardingNameSettingView.swift
//  MenuTaro
//
//  Created by mac mini on 10/23/25.
//

import SwiftUI

struct OnboardingNameSettingView: View {
    @State private var name: String = ""
    var body: some View {
        GeometryReader { proxy in
            VStack (alignment : .leading, spacing : 20){
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
                
                PillTextField(text: $name)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 32)

                Button("다음") {
                    
                }
                .appFont(20, weight: .bold)
                .buttonStyle(OrangeButtonStyle())
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 24)
            }
        }
        .background(Color.black)
        
    }
}

#Preview {
    OnboardingNameSettingView()
}
