//
//  SnackCookie.swift
//  MenuTaro
//
//  Created by 이정은 on 8/23/25.
//

import SwiftUI

struct SnackTaro: View {
    
    @State private var animate = false
    
    let cookies = Array(repeating: "coockie_snack", count: 5)
    
    var body: some View {
        
        VStack{
            VStack{
                    Text("포춘 쿠키")
                        .foregroundColor(.red)
                    + Text("를 하나")
                    Text("선택해주세요!")
            }
                .multilineTextAlignment(.center)
                .font(.system(size: 28, weight: .semibold, design: .default))
                .padding(.top, 176)
                .padding(.bottom, 168)
            
            GeometryReader { geo in   // 화면 크기를 알려주는 도구
                VStack {
                    HStack(spacing: 10) {
                        // 쿠키 줄 1
                        ForEach(0 ..< cookies.count, id: \.self) { _ in
                            cookieCircle()
                        }
                        // 쿠키 줄 2 (복사본 → 끊기지 않고 이어지게)
                        ForEach(0 ..< cookies.count, id: \.self) { _ in
                            cookieCircle()
                        }
                    }
                }
                    .offset(x: animate ? geo.size.width * -1 : 0)
                    .animation(
                        .linear(duration: 8)
                        .repeatForever(autoreverses: false),
                        value: animate
                    )
                    .onAppear {
                        animate = true
                    }
                }
            }
        }
        
    }


#Preview {
    SnackTaro()
}

func cookieCircle() -> some View {
    Circle()
        .frame(width: 150, height: 150)
        .foregroundColor(.red)
        .overlay(
            Image("cookie_snack")
                .resizable()
            //                    .frame(width: 143.84, height: 111.88)
                .scaledToFit()
        )
}
