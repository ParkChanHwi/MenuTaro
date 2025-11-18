//
//  TermsChapterView.swift
//  MenuTaro
//
//  Created by mac mini on 11/18/25.
//
import SwiftUI

struct TermsChapterView: View {
    let chapter: TermsChapter
    @State private var isExpanded: Bool = false

    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(chapter.sections) { section in
                    TermsSectionView(section: section)
                }
            }
            .padding(.top, 8)
        } label: {
            Text(chapter.title)
                .font(.title2)
        }
        .padding(.vertical, 8)
    }
}
