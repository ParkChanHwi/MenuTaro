//
//  InfiniteRow.swift
//  MenuTaro
//
//  Created by 이정은 on 8/29/25.
//

import SwiftUI

enum ScrollDirection { case left, right }

// SnackTaro View에서 쿠키 원형이 한 줄로 무한히 움직이는
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
                cookieCircle(imageName: "cookie_snack", width: 150, height: 150)
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
                let delta = CGFloat(speed * 0.02)
                
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

#Preview {
    InfiniteRow(direction: .right, cookies: ["cookie_snack"])
}
