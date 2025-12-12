//
//  SettingsTermsView.swift
//  MenuTaro
//
//  Created by 장현준 on 11/28/25.
//

import SwiftUI

struct SettingsTermsView: View {
    @Environment(\.dismiss) private var dismiss
    let document: TermsDocument

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                ForEach(document.chapters) { chapter in
                    TermsChapterView(chapter: chapter)
                }

                Spacer(minLength: 32)
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
        }
    }
}

#Preview {
    SettingsTermsView(document: .serviceTerms)
}
