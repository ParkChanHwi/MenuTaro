//
//  ConstantsTestView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/9/25.
//


import SwiftUI

struct ConstantsTestView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("비율 테스트")
                .font(.system(size: 20 * Constants.ControlWidth))
                .padding()

            Rectangle()
                .fill(Color.red)
                .frame(width: 358 * Constants.ControlWidth,
                       height: 124 * Constants.ControlHeight)

            Text("현재 화면 크기: \(Int(Constants.screenWidth)) x \(Int(Constants.screenHeight))")
                .font(.caption)
        }
        .padding()
    }
}

#Preview {
    ConstantsTestView()
}
