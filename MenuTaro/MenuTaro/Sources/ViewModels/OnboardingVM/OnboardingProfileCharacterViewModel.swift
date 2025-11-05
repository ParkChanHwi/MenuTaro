//
//  OnboardingProfileCharacterViewModel.swift
//  MenuTaro
//
//  Created by mac mini on 10/29/25.
//
import SwiftUI

final class OnboardingProfileCharacterViewModel: ObservableObject {
    @Published var selectedCharacter: String?
    let characters: [String]

    init(
        characters: [String] = ["chicken", "tiramisu", "croissant", "iceCream"],
        selectedCharacter: String? = nil
    ) {
        self.characters = characters
        self.selectedCharacter = selectedCharacter
    }

    func toggleSelection(for character: String) {
        if selectedCharacter == character {
            selectedCharacter = nil
        } else {	
            selectedCharacter = character
        }
    }

    func isSelected(_ character: String) -> Bool {
        selectedCharacter == character
    }

    func backgroundStyle(for character: String) -> AnyShapeStyle {
        if isSelected(character) {
            return AnyShapeStyle(ProfileCharacterAvatar.defaultSelectedBackground)
        } else {
            return AnyShapeStyle(ProfileCharacterAvatar.defaultUnselectedBackground)
        }
    }
}
