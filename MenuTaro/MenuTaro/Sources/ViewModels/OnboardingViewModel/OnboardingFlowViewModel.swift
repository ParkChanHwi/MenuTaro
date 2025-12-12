//
//  OnboardingFlowViewModel.swift
//  MenuTaro
//
//  Created by mac mini on 11/5/25.
//


//
//  OnboardingFlowViewModel.swift
//  MenuTaro
//
//  Created by mac mini on 11/5/25.
//

import SwiftUI
import SwiftData
import Combine

@MainActor
final class OnboardingFlowViewModel: ObservableObject {
    @Published var nickname: String = ""
    let characterSelection: OnboardingProfileCharacterViewModel
    @Published private(set) var selectedCharacter: String?
    @AppStorage("hasOnboarded") private var hasOnboarded = false
    private var cancellables = Set<AnyCancellable>()

    init(characters: [String] = ["chicken", "tirami", "croissant", "iceCream"]) {
        let selection = OnboardingProfileCharacterViewModel(characters: characters)
        self.characterSelection = selection
        self.selectedCharacter = selection.selectedCharacter

        selection.$selectedCharacter
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                self?.selectedCharacter = newValue
            }
            .store(in: &cancellables)
    }

    var isNameValid: Bool {
        let trimmed = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
        return (2...10).contains(trimmed.count)
    }

    func reset() {
        nickname = ""
        characterSelection.selectedCharacter = nil
        selectedCharacter = nil
    }

    func preloadExistingUser(from context: ModelContext) {
        var descriptor = FetchDescriptor<User>()
        descriptor.fetchLimit = 1

        if let existing = try? context.fetch(descriptor).first {
            nickname = existing.nickname
            characterSelection.selectedCharacter = existing.profileImage
            selectedCharacter = existing.profileImage
        }
    }

    enum OnboardingError: LocalizedError {
        case invalidNickname
        case missingCharacter

        var errorDescription: String? {
            switch self {
            case .invalidNickname:
                return "닉네임은 2~10자의 한글, 영문 또는 숫자로 입력해주세요."
            case .missingCharacter:
                return "프로필 캐릭터를 선택해주세요."
            }
        }
    }

    func complete(using context: ModelContext) throws {
        let trimmed = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
        guard (2...10).contains(trimmed.count) else {
            throw OnboardingError.invalidNickname
        }
        guard let selectedCharacter else {
            throw OnboardingError.missingCharacter
        }

        var descriptor = FetchDescriptor<User>()
        descriptor.fetchLimit = 1

        if let existing = try context.fetch(descriptor).first {
            existing.nickname = trimmed
            existing.profileImage = selectedCharacter
        } else {
            let user = User(nickname: trimmed, profileImage: selectedCharacter)
            context.insert(user)
        }

        try context.save()
        hasOnboarded = true
    }
}
