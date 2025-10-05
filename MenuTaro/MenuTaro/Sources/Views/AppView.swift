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
                .navigationBarTitleDisplayMode(.inline)
            
            HomeView()
                .tag(Router.Tab.home)
                .tabItem {
                    Image(systemName: "house")
                    Text("홈").appFont(17)
                }
                .navigationBarTitleDisplayMode(.inline)
            
            MypageView()
                .tag(Router.Tab.mypage)
                .tabItem {
                    Image(systemName: "person")
                    Text("마이페이지")
                }
                .navigationTitle("마이페이지")
                .navigationBarTitleDisplayMode(.inline)
        }
        .tint(.primaryRed)
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

