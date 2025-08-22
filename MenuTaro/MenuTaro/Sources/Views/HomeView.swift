//
//  HomeView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/13/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
  
    @Query(sort: \Bookmark.createdAt, order: .reverse)
    private var bookmarks: [Bookmark]
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea(.all)
            
            VStack{
                Image(systemName: "bell.fill")
                    .foregroundColor(.white)
                    .frame(width: 24, height: 22)
                    .padding(.bottom, 62)
                    .padding(.leading, 362)
                HStack{
                    Text("안녕!\n오늘은 뭘\n먹어볼까?")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .semibold, design: .default))
                        .padding(.trailing, 70)
                    
                    ZStack{
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
                            .clipShape(Circle()) // 원 모양에 맞게 잘라줌
                        
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
                
                category(text: "데일리 메뉴 타로", imageName: "card_home")
                category(text: "간식 포춘쿠키", imageName: "cookie_broken_home")
                    .padding(.bottom, 12)
                
                HStack{
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
                    .buttonStyle(.plain) // 기본 버튼 스타일 제거 → 배경/하이라이트 안 뜨게
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


func category(text: String, imageName: String) -> some View {
    Rectangle()
        .fill(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 255/255, green: 73/255, blue: 35/255),
                    Color(red: 33/255, green: 33/255, blue: 33/255)
                ]),
                startPoint: .leading, endPoint: .trailing
            )
        )
        .frame(width: 358, height: 124)
        .cornerRadius(20)
        .overlay(
            HStack{
                Text(text)
                    .font(.system(size: 18, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .frame(width: 126, height: 22)
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 202.52, height: 151.83)
                    .padding(.bottom, 40)
            }
                .padding(.leading, 20)
                .padding(.top, 56)
        )
        .padding(.bottom, 17)
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
