//
//  MenuTaroSelectedViewModel.swift
//  MenuTaro
//
//  Created by mac mini on 11/13/25.
//

import Foundation
import SwiftData

/// `MenuTaroSelectedViewModel`
///
/// 사용자가 선택한 음식 카드(`FoodCard`)에 대한 Bookmark 및 섭취 기록을 관리하는 ViewModel입니다.
/// `SwiftData`의 `ModelContext`를 활용하여 데이터의 저장/삭제를 수행하며,
/// View에서 북마크 상태를 실시간으로 반영할 수 있도록 `ObservableObject`로 정의되어 있습니다.
///
/// - Note: `@MainActor`는 UI 업데이트가 Main Thread에서 안전하게 수행되도록 보장합니다.
@MainActor
final class MenuTaroSelectedViewModel: ObservableObject {
    
    /// SwiftData의 데이터베이스 컨텍스트
    private var modelContext: ModelContext?
    
    /// 현재 선택된 음식 카드 모델
    private let foodCard: FoodCard
    
    /// 현재 로그인된 사용자 정보 - 로그인 기능은 없지만 추후 확장성을 위해 사용
    private var currentUser: User?
    
    /// 해당 음식 카드가 Bookmark 상태인지 여부를 나타냅니다.
    /// `@Published` 속성을 사용하여 View와 상태가 자동으로 동기화됩니다.
    @Published private(set) var isBookmarked: Bool = false
    
    /// ViewModel 초기화 메서드
    ///
    /// - Parameter foodCard: 현재 선택된 음식 카드 객체
    init(foodCard: FoodCard) {
        self.foodCard = foodCard
    }
    
    /// 외부에서 전달받은 `ModelContext`를 설정하고,
    /// 사용자 정보 및 Bookmark 상태를 초기화합니다.
    ///
    /// - Parameter context: SwiftData에서 제공하는 데이터베이스 컨텍스트
    func setContext(_ context: ModelContext) {
        modelContext = context
        loadCurrentUser()
        refreshBookmarkState()
    }
    
    /// Bookmark 버튼이 탭되었을 때 호출됩니다.
    ///
    /// 그렇지 않다면 새로운 Bookmark 엔티티를 생성 후 저장합니다.
    func handleBookmarkTap() {
        guard let context = modelContext else { return }
        // 사용자 정보가 없는 경우 로드 시도
        guard let user = currentUser ?? loadCurrentUser() else { return }
        
        if isBookmarked {
            // 현재 사용자 + 음식 조합의 Bookmark 1개를 찾아 삭제
            let foodId = foodCard.foodId
            let userId = user.userId
            
            var descriptor = FetchDescriptor<Bookmark>(
                predicate: #Predicate<Bookmark> { b in
                    b.food.foodId == foodId && b.user.userId == userId
                }
            )
            descriptor.fetchLimit = 1
            
            do {
                if let target = try context.fetch(descriptor).first {
                    context.delete(target)
                    try context.save()
                    isBookmarked = false
                } else {
                    // 혹시 못 찾으면 상태를 다시 동기화
                    refreshBookmarkState()
                }
            } catch {
                print("Bookmark delete failed: \(error.localizedDescription)")
                refreshBookmarkState()
            }
        } else {
            // 없으면 새로 추가
            let bookmark = Bookmark(
                bookmarkId: UUID(),
                createdAt: Date(),
                food: foodCard,
                user: user
            )
            
            context.insert(bookmark)
            do {
                try context.save()
                isBookmarked = true
            } catch {
                context.delete(bookmark)
                print("Bookmark save failed: \(error.localizedDescription)")
                refreshBookmarkState()
            }
        }
    }
    
    
    /// 음식 섭취(Consumption) 기록을 남깁니다.
    ///
    /// `ConsumptionRecord` 엔티티를 생성하여 현재 시간과 함께 저장합니다.
    func logConsumption() {
        guard let context = modelContext else { return }
        guard let user = currentUser ?? loadCurrentUser() else { return }
        
        let record = ConsumptionRecord(
            recordId: UUID(),
            timestamp: Date(),
            food: foodCard,
            snack: nil,
            user: user
        )
        
        context.insert(record)
        
        do {
            try context.save()
        } catch {
            context.delete(record)
            print("Consumption record save failed: \(error.localizedDescription)")
        }
    }
    
    /// 현재 로그인된 사용자 정보를 데이터베이스에서 불러옵니다.
    ///
    /// - Returns: 로드된 `User` 객체 (없을 경우 `nil`)
    /// - Note: 이미 로드된 사용자가 있다면 이를 그대로 반환합니다.
    @discardableResult
    private func loadCurrentUser() -> User? {
        guard let context = modelContext else {
            currentUser = nil
            return nil
        }
        
        var descriptor = FetchDescriptor<User>()
        descriptor.fetchLimit = 1
        
        do {
            let users = try context.fetch(descriptor)
            currentUser = users.first
        } catch {
            print("Failed to load current user: \(error.localizedDescription)")
            currentUser = nil
        }
        
        return currentUser
    }
    
    /// 현재 음식 카드의 Bookmark 상태를 갱신합니다.
    ///
    /// 현재 사용자와 음식 카드 ID를 기반으로 Bookmark 존재 여부를 확인하여,
    /// `isBookmarked` 상태를 업데이트합니다.
    private func refreshBookmarkState() {
        guard let context = modelContext else {
            isBookmarked = false
            return
        }
        
        guard let user = currentUser ?? loadCurrentUser() else {
            isBookmarked = false
            return
        }
        
        let foodId = foodCard.foodId
        let userId = user.userId
        
        // 특정 음식-사용자 조합의 Bookmark만 조회하도록 Predicate 설정
        var descriptor = FetchDescriptor<Bookmark>(
            predicate: #Predicate<Bookmark> { bookmark in
                bookmark.food.foodId == foodId && bookmark.user.userId == userId
            }
        )
        descriptor.fetchLimit = 1
        
        // fetchDescriptor 실행
        do {
            let bookmarks = try context.fetch(descriptor)
            isBookmarked = !bookmarks.isEmpty
        } catch {
            print("Bookmark state refresh failed: \(error.localizedDescription)")
            isBookmarked = false
        }
    }
}
