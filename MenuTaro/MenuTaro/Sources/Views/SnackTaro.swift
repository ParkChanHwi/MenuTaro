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
    
    // 쿠키를 표시할 이미지 이름 배열
    let cookies = Array(repeating: "cookie_snack", count: 8)
    
    var body: some View {
        NavigationStack {
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
                
                // 화면 크기를 알려주는 도구
                GeometryReader { geo in
                    VStack(spacing: 20) {
                        // 줄1 → 왼쪽으로 무한 스크롤
                        InfiniteRow(direction: .left, cookies: cookies)
                        
                        // 쿠키 터치했을 때
                            .onTapGesture {
                                navigateToSnackTaro2 = true
                                print("화면 넘어감")
                            }
                        
                        // 줄2 → 오른쪽으로 무한 스크롤
                        InfiniteRow(direction: .right, cookies: cookies)
                            .onTapGesture {
                                navigateToSnackTaro2 = true
                                print("화면 넘어감")
                            }
                    }
                    .navigationDestination(isPresented: $navigateToSnackTaro2) {
                        SnackTaro2()
                    }
                }
            }
        }
    }
}

#Preview {
    SnackTaro()
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

