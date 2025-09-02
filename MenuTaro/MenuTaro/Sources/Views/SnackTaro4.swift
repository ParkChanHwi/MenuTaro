//
//  SnackTaro4.swift
//  MenuTaro
//
//  Created by 이정은 on 9/2/25.
//

import SwiftUI

struct SnackTaro4: View {
    var body: some View {
        VStack {
            Text("이번 간식은")
                .font(.system(size: 22, weight: .semibold))
            Text("아이스크림")
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(.primaryRed)
        }
    }
}

#Preview {
    SnackTaro4()
}
