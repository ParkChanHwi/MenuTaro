//
//  AppView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/13/25.
//

import SwiftUI
import SwiftData

struct AppView: View {
    @EnvironmentObject private var router: Router
    
    var body: some View {
        TabView(selection: $router.selectedTab) {
            BookmarkCategoryListView()
                .tag(Router.Tab.bookmarks)
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("북마크").appFont(17)
                }
                .navigationTitle("북마크")
            
            HomeView()
                .tag(Router.Tab.home)
                .tabItem {
                    Image(systemName: "house")
                    Text("홈").appFont(17)
                }
            
            MypageView()
                .tag(Router.Tab.mypage)
                .tabItem {
                    Image(systemName: "person")
                    Text("마이페이지")
                }
                .navigationTitle("마이페이지")
        }
        .tint(.primaryRed)
        .navigationBarTitleDisplayMode(.inline)
        .if(router.selectedTab != .home) { view in
            view.customToolbar(
                title: currentTitle,
                showBackButton: false,
                showGearButton: router.selectedTab == .mypage
            )
        }
    }
    private var currentTitle: String {
        switch router.selectedTab {
        case .bookmarks: return "북마크"
        case .home:      return "" // 홈은 상단바 없음
        case .mypage:    return "마이페이지"
        }
    }
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

#Preview {
    NavigationRootView()
        .modelContainer(makePreviewContainer())
        .environmentObject(Router())
//        .modelContainer(
//            for: [User.self, Snack.self, FoodCard.self, ConsumptionRecord.self, Bookmark.self],
//            inMemory: true
//        )
}

