//
//  FontTestView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/9/25.
//

import SwiftUI

struct FontTestView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("SFPro 일반형 텍스트입니다.")
                .font(.custom("SFPro-Regular", size: 24))
            
            Text("SFPro 강조한 폰트 텍스트입니다.")
                .font(.custom("SFPro-Bold", size: 24))
            
            Text("SFPro 일반형 텍스트입니다.")
                .font(.system(size: 24, weight: .regular, design: .default))
            
            Text("SFPro 강조한 폰트 텍스트입니다.")
                .font(.system(size: 24, weight: .bold, design: .default))
        }
        .padding()
    }
}

#Preview {
    FontTestView()
}
