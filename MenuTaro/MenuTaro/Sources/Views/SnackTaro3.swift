//
//  SnackTaro3.swift
//  MenuTaro
//
//  Created by 이정은 on 8/27/25.
//

import SwiftUI

struct SnackTaro3: View {
    var body: some View {
        VStack {
            Text("과연..!")
                .multilineTextAlignment(.center)
                    .font(.system(size: 28, weight: .semibold))
                    .padding(.top, 176)
                    .padding(.bottom, 108)
            cookieCircle(imageName: "cookie_broken_snack", width: 285, height: 285)
                .padding(.bottom, 259)
        }

    }
}

#Preview {
    SnackTaro3()
}
