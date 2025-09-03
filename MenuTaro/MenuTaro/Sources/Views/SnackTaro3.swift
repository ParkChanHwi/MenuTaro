//
//  SnackTaro3.swift
//  MenuTaro
//
//  Created by 이정은 on 8/27/25.
//

import SwiftUI

struct SnackTaro3: View {
    @State private var text = "과연..!"
    var body: some View {
        VStack {
            Text(text)
                .multilineTextAlignment(.center)
                .font(.system(size: 28, weight: .semibold))
                .padding(.top, 176)
                .padding(.bottom, 108)
            cookieCircle(imageName: "cookie_broken_snack", width: 285, height: 285)
                .padding(.bottom, 259)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                text = "빠직...빠드득...콰직.."
            }       }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                text = "뭐 나올끼니?"
            }       }
    }
}

#Preview {
    SnackTaro3()
}
