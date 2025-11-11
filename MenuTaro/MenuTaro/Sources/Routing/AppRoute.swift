//
//  AppRoute.swift
//  MenuTaro
//
//  Created by hwi on 10/1/25.
//

import Foundation

/// 앱 내에서 이동가능한 모든 화면을 식별하는 열거형입니다.
///
/// 연관값은 최소한의 식별자 수준으로만 구성하여 안전하게 직렬화 할 수 있습니다.
/// 화면별 상태나 복잡한 모델 스냅샷은 보관하지 않습니다.
public enum AppRoute: Hashable {
    case bookmarkList(category: FoodCard.FoodCategory?)
    case snackFortune(step: SnackFortuneStep)
    case menuTaro
    case MenuTaroSelected(foodId: UUID)
    case onboarding(step: OnboardingStep)
    case mypageEdit
    case setting
    case ranking
}

public extension AppRoute {
    /// 복구와 재생성을 위해 사용할 수 있는 경로 식별자입니다.
    /// key-value 구조를 통해 민감한 정보 없이 식별만을 제공해 안전합니다.
    struct Identifier: Hashable, Codable {
        public let key: String
        public let value: String?
        
        public init(key: String, value: String? = nil) {
            self.key = key
            self.value = value
        }
    }
    
    /// 현재 경로에 대응하는 식별자를 반환합니다.
    var identifier: Identifier {
        switch self {
        case let .bookmarkList(category):
            return Identifier(key: "bookmarkList", value: category?.rawValue)
        case let .snackFortune(step):
            return Identifier(key: "snackFortune", value: step.rawValue)
        case .menuTaro:
            return Identifier(key: "menuTaro")
        case let .MenuTaroSelected(foodId):
            return Identifier(key: "MenuTaroSelected", value: foodId.uuidString)
        case let .onboarding(step):
            return Identifier(key: "onboarding", value: step.rawValue)
        case .mypageEdit:
            return Identifier(key: "mypageEdit")
        case .setting:
            return Identifier(key: "setting")
        case .ranking:
            return Identifier(key: "ranking")
        }
    }
    
    ///직렬화된 식별자로부터 라우트를 복원합니다.
    init?(identifier: Identifier) {
        switch identifier.key {
        case "bookmarkList":
            let category: FoodCard.FoodCategory?
            if let rawValue = identifier.value {
                category = FoodCard.FoodCategory(rawValue: rawValue)
            } else {
                category = nil
            }
            self = .bookmarkList(category: category)
        case "snackFortune":
            guard let value = identifier.value,
                  let step = SnackFortuneStep(rawValue: value) else {
                return nil
            }
            self = .snackFortune(step: step)
            
        case "menuTaro":
            self = .menuTaro
            
        case "MenuTaroSelected":
            guard let uuidString = identifier.value,
                  let foodId = UUID(uuidString: uuidString) else {
                return nil
            }
            self = .MenuTaroSelected(foodId: foodId)
        case "onboarding":
            guard let value = identifier.value,
                  let step = OnboardingStep(rawValue: value) else {
                return nil
            }
            self = .onboarding(step: step)
        case "mypageEdit":
            self = .mypageEdit
            
        case "setting":
            self = .setting
            
        case "ranking":
            self = .ranking
            
        default :
            return nil
        }
    }
}

///간식 포춘 쿠키 플로우의 단계를 정의합니다.
public enum SnackFortuneStep: String, Hashable, Codable,CaseIterable {
    case selection
    case opening
    case reveal
    case result
}

public enum OnboardingStep: String, Hashable, Codable, CaseIterable {
    case name
    case profile
    case terms
}
