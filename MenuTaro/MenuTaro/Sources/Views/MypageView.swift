//
//  MypageView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/13/25.
//

import SwiftUI
import SwiftData

private let hInset: CGFloat = 20
private let rowHeight: CGFloat = 140 + 12

struct MypageView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var router: Router
    @StateObject private var vm = MypageViewModel()
    @Query private var users: [User]

    init() {
        var descriptor = FetchDescriptor<User>()
        descriptor.fetchLimit = 1
        _users = Query(descriptor)
    }

    private var currentUser: User? { users.first }
    private var profileImageName: String { currentUser?.profileImage ?? "chicken" }
    private var nickname: String { currentUser?.nickname ?? "머먹을래" }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                customTopbar(title: "마이페이지", showGearButton: true)
                HStack(alignment: .center, spacing: 16) {
                    ProfileCharacterAvatar(
                        imageName: profileImageName,
                        diameter: 120,
                        backgroundStyle: ProfileCharacterAvatar.defaultSelectedBackground
                    )
                    .padding(.leading, 22)

                    VStack(alignment: .leading, spacing: 6) {
                        Text(nickname)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)

                        Text("오늘도 맛있는 하루 보내요")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 153)
                .background(Color.white.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Button(action: {
                    router.push(.mypageEdit)
                }, label: {
                    Text("프로필 편집")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 47)
                        .background(Color(red: 1, green: 0.29, blue: 0.14))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                })

                HStack {
                    Text("7월 랭킹")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    HStack(spacing: 4) {
                        Button {
                            router.push(.ranking)
                        } label: {
                            Text("전체보기")
                                .font(.system(size: 12, weight: .regular, design: .default))
                                .foregroundColor(.gray)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                    }
                }

                HStack {
                    Text("메뉴 랭킹")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(.white)
                    Spacer()
                }
                if vm.menuTop3.isEmpty {
                    Text("타로카드를 뽑아 음식을 추가해보세요!")
                        .frame(height: rowHeight)
                } else {
                    ScrollView(.horizontal) {
                        HStack(spacing: 15) {
                            ForEach(vm.menuTop3) { item in
                                MypageCardView(name: item.food.name, image: item.food.image)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                    .frame(height: rowHeight)
                }

                HStack {
                    Text("간식 랭킹")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(.white)
                    Spacer()
                }
                if vm.snackTop3.isEmpty {
                    Text("포춘쿠키를 뽑아 음식을 추가해보세요!")
                        .frame(height: rowHeight)
                } else {
                    ScrollView(.horizontal) {
                        HStack(spacing: 15) {
                            ForEach(vm.snackTop3) { item in
                                MypageCardView(name: item.snack.name, image: item.snack.image)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                    .frame(height: rowHeight)
                }
                Spacer()
            }
            .padding(.horizontal, hInset)
            .padding(.top, 13)
        }
        .onAppear {
            vm.setContext(context)
            vm.refresh(for: currentUser)
        }
        .onChange(of: users) { _, _ in
            vm.refresh(for: currentUser)
        }
    }
}

#Preview {
    MypageView()
        .background(Color.black)
        .modelContainer(makePreviewContainer())
        .environmentObject(Router())
}
