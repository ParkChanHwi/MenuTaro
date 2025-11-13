//
//  SectionHeaderView.swift
//  MenuTaro
//
//  Created by 장현준 on 11/13/25.
//

import SwiftUI

struct SectionHeaderView: View {
    @EnvironmentObject private var router: Router
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .medium))
            Spacer()
            HStack(spacing: 4) {
                Button {
                    router.push(.calendar)
                } label: {
                    Text("전체보기")
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
