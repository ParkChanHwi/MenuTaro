import SwiftUI
import SwiftData

struct HomeView: View {
    @EnvironmentObject private var router: Router
    @Query private var bookmarks: [Bookmark]
    @Query private var users: [User]

    @Query private var recentRecords: [ConsumptionRecord]
    init() {
        var userDescriptor = FetchDescriptor<User>()
         userDescriptor.fetchLimit = 1
         _users = Query(userDescriptor)

         var bookmarkDescriptor = FetchDescriptor<Bookmark>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
         _bookmarks = Query(bookmarkDescriptor)

         var recentDescriptor = FetchDescriptor<ConsumptionRecord>(
             sortBy: [SortDescriptor(\.timestamp, order: .reverse)]
         )
         recentDescriptor.fetchLimit = 20
         recentDescriptor.predicate = #Predicate { $0.food != nil }
         _recentRecords = Query(recentDescriptor)
    }

    private var currentUser: User? {
        users.first
    }
    
    private var filteredBookmarks: [Bookmark] {
        guard let user = currentUser else { return [] }
        return bookmarks.filter { $0.user.userId == user.userId }
    }

    private var recentFoods: [FoodCard] {
        var seen = Set<UUID>()
        var items: [FoodCard] = []

        for record in recentRecords {
            guard let food = record.food else { continue }
            if seen.insert(food.foodId).inserted {
                items.append(food)
            }
            if items.count >= 10 { break }
        }

        return items
    }

    private var greetingText: String {
        if let nickname = currentUser?.nickname, !nickname.isEmpty {
            return "안녕, \(nickname)!\n오늘은 뭘\n먹어볼까?"
        } else {
            return "안녕!\n오늘은 뭘\n먹어볼까?"
        }
    }

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
                    Text(greetingText)
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ZStack {
                        ProfileCharacterAvatar(
                            imageName: currentUser?.profileImage ?? "chicken",
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

                // 최근에 먹은 메뉴 섹션
                SectionHeaderView(title: "최근에 먹은 메뉴")
                    .padding(.top, sectionHeaderTop)
                    .padding(.horizontal, sidePadding)

                if recentFoods.isEmpty {
                    Text("아직 기록된 메뉴가 없어요")
                        .foregroundColor(.gray)
                        .padding(.top, h * 0.01)
                        .padding(.horizontal, sidePadding)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: recentHSpacing) {
                            ForEach(recentFoods, id: \.foodId) { food in
                                RecentMenuCardView(food: food)
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
        let container = try ModelContainer(
            for: Bookmark.self, FoodCard.self, User.self, ConsumptionRecord.self,
            configurations: config
        )

        let user = User(nickname: "테스트", profileImage: "testProfile")
        let food = FoodCard(foodId: UUID(), name: "치킨", details: "맛있는 치킨", category: .etc, image: "chicken")
        let bookmark = Bookmark(bookmarkId: UUID(), createdAt: Date(), food: food, user: user)

        container.mainContext.insert(user)
        container.mainContext.insert(food)
        let record = ConsumptionRecord(
            recordId: UUID(),
            timestamp: Date(),
            food: food,
            snack: nil,
            user: user
        )

        container.mainContext.insert(bookmark)
        container.mainContext.insert(record)

        return HomeView()
            .environmentObject(Router())
            .modelContainer(container)
    } catch {
        fatalError("Preview 실패: \(error.localizedDescription)")
    }
}

private struct SectionHeaderView: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .medium))

            Spacer()
        }
    }
}

private struct RecentMenuCardView: View {
    let food: FoodCard

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(food.image.isEmpty ? "cardfront" : food.image)
                .resizable()
                .scaledToFill()
                .frame(width: 140, height: 140)
                .clipped()
                .cornerRadius(16)

            VStack(alignment: .leading, spacing: 4) {
                Text(food.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(1)

                Text(food.category.rawValue)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 140, alignment: .leading)
    }
}
