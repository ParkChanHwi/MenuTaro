//
//  Router.swift
//  MenuTaro
//
//  Created by hwi on 10/1/25.
//

import Foundation
import SwiftUI

/// 앱 전역의 네비게이션 경로를 Single-RespondsibilityPrinciple에 따라 단일 책임으로 관리하는 Router 입니다.
@MainActor
public final class Router: ObservableObject {
    public enum Tab: Hashable, CaseIterable {
        case bookmarks
        case home
        case mypage
    }
    
    /// 현재 선택된 탭 상태, TabView에 바인딩됩니다.
    @Published public var selectedTab: Tab = .home
    
    /// NavigationStack과 연결되는 경로 스택입니다. - AppRoute File을 통해 경로 받아옴
    @Published public private(set) var path: [AppRoute] = []
    
    /// 전환 중에 중첩 호출이 발생했을 때 순서를 보장하기 위한 큐입니다.
    private var pendingCommands: [NavigationCommand] = []
    private var isProcessingCommands = false
    
    public init() {}
    
    // MARK: - Public Commands
    
    public func push(_ route: AppRoute) {
        enqueue(.push(route))
    }
    
    public func pop() {
        enqueue(.pop)
    }
    
    public func popToRoot() {
        enqueue(.popToRoot)
    }
    
    public func pop(to index: Int) {
        enqueue(.popTo(index))
    }
    
    public func pop(to route: AppRoute) {
        guard let index = path.lastIndex(of: route) else { return }
    }
    
    public func replace(with routes: [AppRoute]) {
        enqueue(.replace(routes))
    }
    
    public func select(tab: Tab) {
        enqueue(.setTab(tab))
    }
    
    /// 조건을 검사한 뒤 네비게이션 명령을 수행합니다.
    public func navigateIf(_ predicate: () -> Bool,
                           success: NavigationCommand,
                           failure: NavigationCommand? = nil) {
        enqueue(predicate() ? success : (failure ?? .none))
    }
    
    /// 비동기 작업의 완료 결과에 따라 네비게이션 명령을 실행합니다.
    public func onAsyncCompletion(_ work: @escaping () async -> NavigationCommand) {
        Task { [weak self] in
            guard let self else { return }
            let command = await work()
            await self.enqueue(command)
        }
    }
    
    /// 지정된 경로 식별자 배열로부터 경로를 복원합니다.
    public func restore(using identifiers: [AppRoute.Identifier]) {
        let restored = identifiers.compactMap(AppRoute.init(identifier:))
        enqueue(.replace(restored))
    }
    
    /// 현재 경로를 직렬화 가능한 식별자 배열로 제공합니다.
    public var persistedIdentifiers: [AppRoute.Identifier] {
        path.map(\.identifier)
    }
    
    // MARK : - Queue Handling
    
    private func enqueue(_ command: NavigationCommand) {
        pendingCommands.append(command)
        processQueueIfNeeded()
    }
    
    private func processQueueIfNeeded() {
        guard !isProcessingCommands else { return }
        isProcessingCommands = true
        while !pendingCommands.isEmpty {
            let command = pendingCommands.removeFirst()
            apply(command)
        }
    }
    
    private func apply(_ command: NavigationCommand) {
        switch command {
        case .none:
            return
        case let .push(route):
            withAnimation(.easeInOut) {
                path.append(route)
            }
        case .pop:
            guard !path.isEmpty else { return }
            withAnimation(.easeInOut) {
                path.removeLast()
            }
        case .popToRoot:
            guard !path.isEmpty else { return }
            withAnimation(.easeInOut) {
                path.removeAll()
            }
        case let .popTo(index):
            guard index >= 0, index < path.count else {return}
            let targetCount = index + 1
            guard targetCount < path.count else { return }
            withAnimation(.easeInOut) {
                path.removeSubrange(targetCount..<path.count)
            }
        case let .replace(routes):
            guard path != routes else { return }
            withAnimation(.easeInOut) {
                path = routes
            }
        case let .setTab(tab):
            guard selectedTab != tab else {return}
            withAnimation(.easeInOut) {
                selectedTab = tab
            }
        }
    }
}

/// Router가 해석할 수 있는 전환 명령 타입입니다.
public enum NavigationCommand {
    case none
    case push(AppRoute)
    case pop
    case popToRoot
    case popTo(Int)
    case replace([AppRoute])
    case setTab(Router.Tab)
}
