//
//  SnackTaro4.swift
//  MenuTaro
//
//  Created by 이정은 on 9/2/25.
//

import SwiftUI

struct SnackTaro4: View {
    @EnvironmentObject private var router: Router
    var body: some View {
        VStack(spacing:32) {
            VStack {
                Text("이번 간식은")
                    .font(.system(size: 22, weight: .semibold))
                Text("아이스크림")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.primaryRed)
            }
            
            Button {
                router.pop(to: .snackFortune(step:.selection))
            }label: {
                Text("다시 뽑을래요")
                    .font(.system(size: 18, weight: .medium))
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.1))
                    .clipShape(Capsule())
            }
            
            
            Button {
                router.popToRoot()
            } label: {
                Text("홈으로 돌아가기")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color("buttonOrange"))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(.horizontal, 24)
        }
        .padding(.top, 120)
    }
}

#Preview {
    SnackTaro4()
        .environmentObject(Router())
}
