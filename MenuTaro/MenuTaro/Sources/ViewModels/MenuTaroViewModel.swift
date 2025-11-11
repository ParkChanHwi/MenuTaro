//
//  MenuTaroViewModel.swift
//  MenuTaro
//
//  Created by mac mini on 11/11/25.
//

import Foundation
import SwiftData

/// # MenuTaro의 RadialLayout을 위한 카드 세트를 준비하는 뷰 모델
///
/// 뷰 모델은 25개의 고정된 카드를 선택하는 역할을 한다.
/// SwiftData를 사용해 사용자에게 특정한 덱을 제공
final class MenuTaroViewModel: ObservableObject {
    /// The cards currently displayed on the radial deck.
    @Published private(set) var deckCards: [FoodCard] = []

    /// RadialLayout에 포함될 최대 카드 개수
    private let deckCardLimit: Int

    /// 덱을 구성하는 카드 정보
    private let seedDataProvider: () -> [FoodCardSeed]

    /// Creates a new view model.
    /// - Parameters:
    ///   - deckCardLimit: 덱에 허용되는 최대 카드 수
    ///   - seedDataProvider: 시드 데이터 목록을 반환하는 클로저 기본값 :  ``AppSeedData.foodCards``.
    init(
        deckCardLimit: Int = 25,
        seedDataProvider: @escaping () -> [FoodCardSeed] = { AppSeedData.foodCards }
    ) {
        self.deckCardLimit = deckCardLimit
        self.seedDataProvider = seedDataProvider
    }
    
    /// 주어진 FoodCard 배열을 기반으로 카드 덱을 구성하는 함수입니다.
    /// - Parameter cards: SwiftData에서 가져온 전체 카드 목록
    ///
    /// 1. 전달받은 카드 목록이 비어 있으면 덱을 초기화하고 종료합니다.
    /// 2. 카드 이름을 키로 하는 딕셔너리를 생성하여 빠르게 조회할 수 있도록 합니다.
    /// 3. 시드 데이터(seedDataProvider)와 이름이 일치하는 카드를 찾아 기본 덱 후보로 설정합니다.
    /// 4. 일치하는 시드 데이터가 없으면 모든 카드를 무작위로 섞어 사용합니다.
    /// 5. 덱의 카드 개수를 제한(deckCardLimit)하여 최종 덱을 구성합니다.
    ///
    func buildDeck(from cards: [FoodCard]) {
        guard !cards.isEmpty else {
            deckCards = []
            return
        }

        let cardsByName = Dictionary(uniqueKeysWithValues: cards.map { ($0.name, $0) })

        let seededMatches = seedDataProvider().compactMap { seed -> FoodCard? in
            cardsByName[seed.name]
        }

        let baseDeck: [FoodCard]

        if seededMatches.isEmpty {
            baseDeck = cards.shuffled()
        } else {
            baseDeck = seededMatches.shuffled()
        }

        deckCards = Array(baseDeck.prefix(min(deckCardLimit, baseDeck.count)))
    }
}
