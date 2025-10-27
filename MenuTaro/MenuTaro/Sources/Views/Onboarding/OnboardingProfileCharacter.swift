//
//  OnboardingProfileCharacter.swift
//  MenuTaro
//
//  Created by mac mini on 10/27/25.
//  온보딩 - 2 프로필 캐릭터 선택

import SwiftUI

struct OnboardingProfileCharacter: View {
    @State private var selectedCharacter: String = ""
    var body: some View {
        GeometryReader { proxy in
            let matrics = MenuTaroLayoutMetrics.metrics(for: proxy.size)
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("2/3")
                        .font(.system(.subheadline, weight: .bold))
                        .foregroundColor(.primaryRed)
                        .padding(.leading, proxy.size.width * 0.1)
                    Text("프로필 캐릭터를/n선택해주세요.")
                        .font(.system(.title, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.leading, proxy.size.width * 0.1)
                    Text("*캐릭터는 언제든지 바꿀 수 있어요!")
                        .font(.system(.caption, weight: .regular))
                        .foregroundColor(.white)
                        .padding(.leading, proxy.size.width * 0.1)
                    HStack {
                        
                        
                    }
                    
                }
            }
            
        }
    }
}

#Preview {
    OnboardingProfileCharacter()
}
