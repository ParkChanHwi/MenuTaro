//
//  MypageEditView.swift
//  MenuTaro
//
//  Created by mac mini on 11/5/25.
//


//
//  MypageEditView.swift
//  MenuTaro
//
//  Created by mac mini on 11/5/25.
//

import SwiftUI
import SwiftData

struct MypageEditView: View {
    @EnvironmentObject private var router: Router
    @Environment(\.modelContext) private var modelContext
    @State private var name: String = ""
    @StateObject private var viewModel = OnboardingProfileCharacterViewModel()
    @Query private var users: [User]
    @State private var errorMessage: String?
    @State private var didInitialize = false

    init() {
        var descriptor = FetchDescriptor<User>()
        descriptor.fetchLimit = 1
        _users = Query(descriptor)
    }

    private var currentUser: User? { users.first }

    private var isSaveEnabled: Bool {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        return (2...10).contains(trimmed.count) && (viewModel.selectedCharacter != nil)
    }

    var body: some View {
        GeometryReader { proxy in
            let metrics = MenuTaroLayoutMetrics.metrics(for: proxy.size)

            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("닉네임")
                        .font(.system(.title, weight: .bold))
                        .padding(.leading, proxy.size.width * 0.08)
                        .foregroundColor(.white)

                    PillTextField(text: $name)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 32)

                    Text("*닉네임은 한글, 영문, 숫자(2~10)자 이내로 작성해주세요!")
                        .foregroundColor(.primaryRed)
                        .font(.system(.caption, weight: .medium))
                        .padding(.leading, proxy.size.width * 0.1)

                    Text("프로필 캐릭터")
                        .font(.system(.title, weight: .bold))
                        .padding(.top, proxy.size.height * 0.03)
                        .padding(.leading, proxy.size.width * 0.08)
                        .foregroundColor(.white)

                    ProfileCharacterGrid(viewModel: viewModel)
                        .frame(minHeight: proxy.size.height * 0.35)
                        .padding(.bottom, metrics.callToActionHeight + metrics.orangeButtonBottomInset)
                }

                VStack(spacing: 12) {
                    if let errorMessage {
                        Text(errorMessage)
                            .font(.system(.footnote, weight: .medium))
                            .foregroundColor(.primaryRed)
                    }

                    Button("저장") {
                        saveChanges()
                    }
                    .appFont(20, weight: .bold)
                    .frame(height: metrics.callToActionHeight)
                    .buttonStyle(OrangeButtonStyle())
                    .disabled(!isSaveEnabled)
                    .opacity(isSaveEnabled ? 1 : 0.5)
                }
                .padding(.horizontal, metrics.horizontalPadding)
                .padding(.bottom, metrics.orangeButtonBottomInset)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)

            }
        }
        .background(Color.black)
        .onAppear(perform: synchronizeUser)
        .onChange(of: users) { _, _ in
            synchronizeUser()
        }
    }
}

#Preview {
    MypageEditView()
        .environmentObject(Router())
        .modelContainer(makePreviewContainer())
}

private extension MypageEditView {
    func synchronizeUser() {
        guard !didInitialize, let user = currentUser else { return }
        name = user.nickname
        viewModel.selectedCharacter = user.profileImage
        didInitialize = true
    }

    func saveChanges() {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)

        guard (2...10).contains(trimmed.count) else {
            errorMessage = OnboardingFlowViewModel.OnboardingError.invalidNickname.errorDescription
            return
        }

        guard let selected = viewModel.selectedCharacter else {
            errorMessage = OnboardingFlowViewModel.OnboardingError.missingCharacter.errorDescription
            return
        }

        do {
            if let user = currentUser {
                user.nickname = trimmed
                user.profileImage = selected
            } else {
                let user = User(nickname: trimmed, profileImage: selected)
                modelContext.insert(user)
            }

            try modelContext.save()
            errorMessage = nil
            router.pop()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
