//
//  SnackCookie.swift
//  MenuTaro
//
//  Created by 이정은 on 8/23/25.
//

import SwiftUI

struct SnackTaro: View {
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
            
            // 화면 크기를 알려주는 도구
            GeometryReader { geo in
                VStack(spacing: 20) {
                    // 줄1 → 왼쪽으로 무한 스크롤
                    InfiniteRow(direction: .left, cookies: cookies)
                    
                    // 줄2 → 오른쪽으로 무한 스크롤
                    InfiniteRow(direction: .right, cookies: cookies)
                }
            }
        }
    }
}

#Preview {
    SnackTaro()
}

// MARK: - 무한 스크롤 줄을 위한 보조 뷰

enum ScrollDirection { case left, right }

/// 무한 스크롤 줄을 담당하는 별도의 뷰
struct InfiniteRow: View {
    let direction: ScrollDirection
    let cookies: [String]
    
    @State private var xOffset: CGFloat = 0
    
    var body: some View {
        let cookieWidth: CGFloat = 150
        let spacing: CGFloat = 10
        let singleItemWidth = cookieWidth + spacing
        let totalItems = cookies.count * 20 // 화면에 충분히 많이 보이도록 넉넉하게 반복
        let totalWidth = singleItemWidth * CGFloat(totalItems)
        
        HStack(spacing: spacing) {
            ForEach(0..<totalItems, id: \.self) { _ in
                cookieCircle(width: 150, height: 150)
            }
        }
        .offset(x: xOffset)
        .onAppear {
            let speed: CGFloat = 50 // px/sec
            
            // 오른쪽으로 이동할 때 왼쪽 부분에 쿠키가 없는 현상을 해결
            if direction == .right {
                xOffset = -totalWidth / 2
            }
            
            
            // 타이머를 사용하여 오프셋을 직접 업데이트
            Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
                let delta = CGFloat(speed * 0.016)
                
                switch direction {
                case .left:
                    xOffset -= delta
                    // 오프셋이 특정 임계값에 도달하면 리셋하여 끊김 없도록 함
                    if xOffset <= -totalWidth / 2 {
                        xOffset += totalWidth / 2
                    }
                case .right:
                    xOffset += delta
                    // 오프셋이 특정 임계값에 도달하면 리셋하여 끊김 없도록 함
                    if xOffset >= totalWidth / 2 {
                        xOffset -= totalWidth / 2
                    }
                }
            }
        }
        .padding(.bottom, 158)
        .frame(height: cookieWidth)
    }
}

/// 쿠키 이미지가 들어간 원형 뷰
func cookieCircle(width: CGFloat, height: CGFloat) -> some View {
    Circle()
        .frame(width: width, height: height)
        .foregroundColor(.red)
        .overlay(
            Image("cookie_snack")
                .resizable()
                .scaledToFit()
        )
}
