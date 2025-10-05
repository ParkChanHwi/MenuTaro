//
//  SnackCookie.swift
//  MenuTaro
//
//  Created by 이정은 on 8/23/25.
//

import SwiftUI

struct SnackTaro: View {
    // SanckTaro2로 넘어갈지 결정하는 상태 변수
    @State private var navigateToSnackTaro2 = false
    @EnvironmentObject private var router: Router
    // 쿠키를 표시할 이미지 이름 배열
    let cookies = Array(repeating: "cookie_snack", count: 8)
    
    var body: some View {
        VStack {
            VStack {
                Text("포춘 쿠키")
                    .foregroundColor(.red)
                + Text("를 하나")
                Text("선택해주세요!")
            }
            .multilineTextAlignment(.center)
            .font(.system(size: 28, weight: .semibold))
            .padding(.top, 176)
            .padding(.bottom, 168)

            GeometryReader { _ in
                VStack(spacing: 20) {
                    InfiniteRow(direction: .left, cookies: cookies)
                        .onTapGesture {
                            router.push(.snackFortune(step: .opening))
                        }

                    InfiniteRow(direction: .right, cookies: cookies)
                        .onTapGesture {
                            router.push(.snackFortune(step: .opening))
                        }
                }
            }
        }
    }
}

#Preview {
    SnackTaro()
        .environmentObject(Router())
}

/// 쿠키 이미지가 들어간 원형 뷰

func cookieCircle(imageName: String, width: CGFloat, height: CGFloat) -> some View {
    Circle()
        .frame(width: width, height: height)
        .foregroundColor(.red)
        .overlay(
            Image(imageName)
                .resizable()
                .scaledToFit()
        )
}

