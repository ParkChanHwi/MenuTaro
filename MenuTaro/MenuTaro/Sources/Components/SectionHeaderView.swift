//
//  SectionHeaderView.swift
//  MenuTaro
//
//  Created by 장현준 on 11/13/25.
//

import SwiftUI

struct SectionHeaderView: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .medium))
            Spacer()
        }
    }
}
