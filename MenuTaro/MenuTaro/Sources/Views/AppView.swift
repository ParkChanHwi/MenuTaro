//
//  AppView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/13/25.
//

import SwiftUI
import SwiftData

struct AppView: View {
    var body: some View {
        ZStack {
            Color.clear.appBackground()
            
            TabView {
                NavigationStack {
                    BookmarkView()
                        .navigationTitle("북마크")
                        .navigationBarTitleDisplayMode(.inline)
                        .background(Color.clear) // 개별 뷰 배경 제거
                }
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("북마크").appFont(17)
                }
                
                NavigationStack {
                    HomeView()
                        .navigationBarTitleDisplayMode(.inline)
                        .background(Color.clear)
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("홈").appFont(17)
                }
                
                NavigationStack {
                    MypageView()
                        .navigationTitle("마이페이지")
                        .navigationBarTitleDisplayMode(.inline)
                        .background(Color.clear)
                        .toolbar {
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        Button {
                                            // 톱니바퀴 눌렀을 때 동작 추가(타이틀 옆)
                                        } label: {
                                            Image(systemName: "gearshape")
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                }
                .tabItem {
                    Image(systemName: "person")
                    Text("마이페이지").appFont(17)
                }
            }
            .accentColor(.primaryRed)
        }
        .preferredColorScheme(.dark)
    }
}


#Preview {
    AppView()
        .modelContainer(makePreviewContainer())
//        .modelContainer(
//            for: [User.self, Snack.self, FoodCard.self, ConsumptionRecord.self, Bookmark.self],
//            inMemory: true
//        )
}

