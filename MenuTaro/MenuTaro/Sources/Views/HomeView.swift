//
//  HomeView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/13/25.
//

import SwiftUI
import SwiftData

// HomeView.swift

struct HomeView: View {
  
    @Query(sort: \Bookmark.createdAt, order: .reverse)
    private var bookmarks: [Bookmark]
    
    var body: some View {
        ZStack{
            VStack {
                Image(systemName: "bell.fill")
                    .foregroundColor(.white)
                    .frame(width: 24, height: 22)
                    .padding(.bottom, 62)
                    .padding(.leading, 362)
                
                HStack {
                    Text("안녕!\n오늘은 뭘\n먹어볼까?")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .semibold, design: .default))
                        .padding(.trailing, 70)
                    
                    // 기존 Circle 이미지 부분 그대로 두기
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 33/255, green: 33/255, blue: 33/255),
                                        Color(red: 255/255, green: 73/255, blue: 35/255)
                                    ]),
                                    startPoint: .top, endPoint: .bottom
                                )
                            )
                            .frame(width: 160, height: 160)
                            .cornerRadius(100)
                        
                        Image("chicken")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 159.26, height: 160)
                            .clipShape(Circle())
                        
                        RoundedRectangle(cornerRadius: 18)
                            .fill(.red)
                            .frame(width: 99, height: 36)
                            .overlay(
                                Text("머먹을래?")
                                    .foregroundColor(.glassShadowBlack10)
                                    .font(.system(size: 18, weight: .medium, design: .default))
                                    .lineSpacing(20)
                            )
                            .offset(y: -68)
                    }
                }
                
                VStack(spacing : 8) {
                    GradientCardView(width: 358, height: 124) {
                        HStack {
                            Text("데일리 메뉴 타로")
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(.white)
                                .frame(width: 126, height: 22)
                            
                            Image("card_home")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 202.52, height: 151.83)
                        }
                        .padding(.leading, 20)
                    }
                    
                    GradientCardView(width: 358, height: 124) {
                        HStack {
                            Text("간식 포춘쿠키")
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(.white)
                                .frame(width: 126, height: 22)
                            
                            Image("cookie_broken_home")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 202.52, height: 151.83)
                        }
                    }
                }
                .padding(.bottom, 12)

                
                // 이하 "최근에 먹은 메뉴" 부분 그대로 유지
                HStack {
                    Text("최근에 먹은 메뉴")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .padding(.trailing, 177)
                    
                    Button(action: {
                        print("전체보기 버튼 클릭됨")
                    }) {
                        HStack(spacing: 5) {
                            Text("전체보기")
                            Image(systemName: "chevron.right")
                                .resizable()
                                .frame(width: 7, height: 14)
                        }
                        .foregroundColor(.gray)
                        .font(.custom("SFPro-Regular", size: 12))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 20)
                
                if bookmarks.isEmpty {
                    Text("아직 북마크 X")
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 18) {
                            ForEach(bookmarks.prefix(5), id: \.persistentModelID) { bookmark in
                                BookmarkCardView(bookmark: bookmark)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
    }
}

extension Color {
    static let myColor1 = Color("myColor1")
    static let myColor2 = Color("myColor2")
}



#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Bookmark.self, FoodCard.self, User.self, configurations: config)

        let user = User(nickname: "테스트", profileImage: "testProfile")
        let food = FoodCard(foodId: UUID(), name: "치킨", details: "맛있는 치킨", category: .etc, image: "chicken")
        let bookmark = Bookmark(bookmarkId: UUID(), createdAt: Date(), food: food, user: user)

        container.mainContext.insert(user)
        container.mainContext.insert(food)
        container.mainContext.insert(bookmark)

        return HomeView()
            .modelContainer(container)
    } catch {
        fatalError("Preview 실패: \(error.localizedDescription)")
    }
}
