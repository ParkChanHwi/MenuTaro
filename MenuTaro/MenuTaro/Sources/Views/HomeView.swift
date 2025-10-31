import SwiftUI
import SwiftData

struct HomeView: View {
    @EnvironmentObject private var router: Router
    @Query(sort: \Bookmark.createdAt, order: .reverse)
    private var bookmarks: [Bookmark]

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            // 비율 상수
            let sidePadding = w * 0.051
            let bellSize = min(w * 0.062, 24)
            let heroCircle = w * 0.41
            let heroBubbleW = w * 0.254
            let heroBubbleH = w * 0.092
            let heroBubbleOffsetY = -heroCircle * 0.425
            let heroSectionSpacing = h * 0.02
            let gradientCardW = w * 0.918
            let gradientCardH = gradientCardW * (124.0/358.0)
            let gradientInternalLeading = w * 0.051
            let sectionHeaderTop = h * 0.02
            let recentHSpacing = w * 0.046

            VStack(alignment: .leading, spacing: 0) {

                HStack {
                    Spacer()
                    Image(systemName: "bell.fill")
                        .foregroundColor(.white)
                        .frame(width: bellSize, height: bellSize)
                }
                .padding(.trailing, sidePadding)

                
                HStack(alignment: .center, spacing: w * 0.04) {
                    Text("안녕!\n오늘은 뭘\n먹어볼까?")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ZStack {
                        ProfileCharacterAvatar(
                            imageName: "chicken",
                            diameter: heroCircle,
                            backgroundStyle: ProfileCharacterAvatar.defaultSelectedBackground
                        )

                        RoundedRectangle(cornerRadius: 18)
                            .fill(.red)
                            .frame(width: heroBubbleW, height: heroBubbleH)
                            .overlay(
                                Text("머먹을래?")
                                    .foregroundColor(.glassShadowBlack10)
                                    .font(.system(size: 18, weight: .medium))
                            )
                            .offset(y: heroBubbleOffsetY)
                    }
                    .frame(width: heroCircle, height: heroCircle)
                }
                .padding(.horizontal, sidePadding)
                .padding(.top, heroSectionSpacing)

                // 기능 카드
                VStack(spacing: h * 0.012) {
                    Button {
                        router.push(.menuTaro)
                    } label: {
                        GradientCardView(width: gradientCardW, height: gradientCardH) {
                            HStack {
                                Text("데일리 메뉴 타로")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Image("card_home")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: gradientCardW * 0.565, height: gradientCardH * 1.225)
                            }
                            .padding(.leading, gradientInternalLeading)
                        }
                    }
                    .buttonStyle(.plain)

                    Button {
                        router.push(.snackFortune(step: .selection))
                    } label: {
                        GradientCardView(width: gradientCardW, height: gradientCardH) {
                            HStack {
                                Text("간식 포춘쿠키")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Image("cookie_broken_home")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: gradientCardW * 0.565, height: gradientCardH * 1.225)
                            }
                            .padding(.leading, gradientInternalLeading)
                            .padding(.bottom, gradientCardH * 0.097)
                        }
                    }
                    .buttonStyle(.plain)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, h * 0.016)
                .padding(.horizontal, (w - gradientCardW) / 2)

                // 섹션 헤더
                HStack {
                    Text("최근에 먹은 메뉴")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))

                    Spacer()

                    Button(action: { print("전체보기 버튼 클릭됨") }) {
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
                .padding(.top, sectionHeaderTop)
                .padding(.horizontal, sidePadding)

                // 북마크 영역
                if bookmarks.isEmpty {
                    Text("아직 북마크 X")
                        .foregroundColor(.gray)
                        .padding(.top, h * 0.01)
                        .padding(.horizontal, sidePadding)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: recentHSpacing) {
                            ForEach(bookmarks.prefix(5), id: \.persistentModelID) { bookmark in
                                BookmarkCardView(bookmark: bookmark)
                            }
                        }
                        .padding(.horizontal, sidePadding)
                        .padding(.vertical, h * 0.012)
                    }
                }

                Spacer(minLength: 0)
            }
            .safeAreaPadding(.top)
        }
        .navigationTitle("홈")
        .navigationBarTitleDisplayMode(.inline)
        // 배경/ignoresSafeArea 관련 수정 없음(상위에서 결정)
    }
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
            .environmentObject(Router())
            .modelContainer(container)
    } catch {
        fatalError("Preview 실패: \(error.localizedDescription)")
    }
}
