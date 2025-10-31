//
//  PillTextField.swift
//  MenuTaro
//
//  Created by mac mini on 10/23/25.
//


import SwiftUI

struct PillTextField: View {
    @Binding var text: String
    var placeholder: String = "닉네임을 입력해주세요."
    var maxLength: Int = 10
    var cornerRadius: CGFloat = 15
    @FocusState private var focused: Bool

    var body: some View {
        HStack(spacing: 8) {
            TextField(placeholder, text: $text)
                .font(.system(.headline, weight: .bold))
                .focused($focused)
                .textInputAutocapitalization(.never)
                .foregroundStyle(.white)
                .submitLabel(.done)
                .onChange(of: text) { _, new in
                    if new.count > maxLength { text = String(new.prefix(maxLength)) }
                }

            Spacer(minLength: 8)

            Text("\(text.count)/\(maxLength)")
                .font(.caption2)
                .monospacedDigit()
                .foregroundStyle(.white)

            if !text.isEmpty {
                Button {
                    text.removeAll()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color(.buttonGrey))
                        .font(.headline.weight(.bold))
                        .padding(6)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("지우기")
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(Color(.buttonGrey), lineWidth: 2)
        )
        .contentShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .onTapGesture { focused = true }
    }
}


#Preview {
    OnboardingNameSettingView()
}
