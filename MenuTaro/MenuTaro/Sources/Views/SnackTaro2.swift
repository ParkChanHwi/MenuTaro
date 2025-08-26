//
//  SnackTaro2.swift
//  MenuTaro
//
//  Created by 이정은 on 8/27/25.
//
import SwiftUI

struct SnackTaro2: View {
    var body: some View {
        VStack {
            VStack {
                Text("쿠키를 터치해서")
                Text("열어주세요!")
            } .multilineTextAlignment(.center)
                .font(.system(size: 28, weight: .semibold))
                .padding(.top, 176)
                .padding(.bottom, 72)
            
            cookieCircle(width: 285, height: 285)
                .padding(.bottom, 269)
            
        }
    }
}

#Preview {
    SnackTaro2()
}
