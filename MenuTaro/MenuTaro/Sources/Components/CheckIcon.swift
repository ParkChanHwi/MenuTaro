//
//  CheckIcon.swift
//  MenuTaro
//
//  Created by mac mini on 10/29/25.
//
import SwiftUI

struct CheckIcon: View {
    let isOn: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(Color("primaryRed"), lineWidth: 2)
                .frame(width: 28, height: 28)
            if isOn {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color("primaryRed"))
                    .frame(width: 28, height: 28)
                    .overlay(
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                    )
            }
        }
        .accessibilityHidden(true)
    }
}
