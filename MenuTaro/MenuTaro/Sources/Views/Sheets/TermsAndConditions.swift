//
//  TermsAndConditions.swift
//  MenuTaro
//
//  Created by mac mini on 11/17/25.
//

import SwiftUI

struct TermsAndConditions: View {
    @Environment(\.presentationMode) var presentation
    let chapter: [TermsChapter] = TermsChapter.Terms_Ko

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                HStack {
                    Text("앱 기본 이용약관")
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Text("닫기").bold()
                    }
                }


                ForEach(chapter) { chapter in
                    TermsChapterView(chapter: chapter)
                }
                Spacer(minLength: 32)
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
        }
        .navigationTitle("이용약관")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    TermsAndConditions()
}
