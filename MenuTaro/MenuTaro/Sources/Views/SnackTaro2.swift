//
//  SnackTaro2.swift
//  MenuTaro
//
//  Created by 이정은 on 8/27/25.
//
import SwiftUI

struct SnackTaro2: View {
    // SanckTaro3로 넘어갈지 결정하는 상태 변수
    @State private var navigateToSnackTaro3 = false
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text("쿠키를 터치해서")
                    Text("열어주세요!")
                } .multilineTextAlignment(.center)
                    .font(.system(size: 28, weight: .semibold))
                    .padding(.top, 176)
                    .padding(.bottom, 72)
                //            NavigationLink
                cookieCircle(imageName: "cookie_snack", width: 285, height: 285)
                // 쿠키 터치했을 때
                    .onTapGesture {
                        navigateToSnackTaro3 = true
                        print("터치")
                    }
                    .padding(.bottom, 269)
            }
            // navigateSnackTaro3가 true일 때, SnackTaro3 View로 변환
            .navigationDestination(isPresented: $navigateToSnackTaro3) {
                SnackTaro3()
            }
        }
    }
}

#Preview {
    SnackTaro2()
}
