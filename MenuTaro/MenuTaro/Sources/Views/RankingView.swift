//
//  RankingView.swift
//  MenuTaro
//
//  Created by 장현준 on 10/31/25.
//

import SwiftUI
import SwiftData

private let hInset: CGFloat = 20

struct RankingView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var router: Router
    @Environment(\.modelContext) private var context
    @StateObject private var vm = MypageViewModel()
    @State private var selectedTab: String = "음식"
    let tabs = ["음식", "간식"]

    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 130) {
                    ForEach(tabs, id: \.self) { tab in
                        Button {
                            selectedTab = tab
                        } label: {
                            Text(tab)
                                .font(.system(size: 16, weight: .semibold))
                                .frame(width: 30)
                                .foregroundColor(
                                    selectedTab == tab ? Color(red: 1, green: 0.29, blue: 0.14) : .gray
                                )
                        }
                    }
                }
                .padding(.horizontal, hInset)
                .padding(.bottom, 25)
                
                switch selectedTab {
                case "음식":
                    if vm.menuTop3.isEmpty {
                        Text("아직 음식 기록이 없어요")
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .padding(.bottom, 150)
                    } else {
                        ForEach(Array(vm.menuTop3.enumerated()), id: \.1.id) { index, item in
                            RankingCardView(
                                rank: index + 1,
                                name: item.food.name,
                                image: item.food.image,
                                countText: "\(item.count)회",
                                isTop3: index < 3
                            )
                        }
                        .padding(.horizontal, hInset)
                    }
                    
                case "간식":
                    if vm.snackTop3.isEmpty {
                        Text("아직 간식 기록이 없어요")
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .padding(.bottom, 150)
                    } else {
                        ForEach(Array(vm.snackTop3.enumerated()), id: \.1.id) { index, item in
                            RankingCardView(
                                rank: index + 1,
                                name: item.snack.name,
                                image: item.snack.image,
                                countText: "\(item.count)회",
                                isTop3: index < 3
                            )
                        }
                        .padding(.horizontal, hInset)
                    }
                default:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .onAppear {
            vm.setContext(context)
            vm.fetchMenuTop3(limit: 10)
            vm.fetchSnackTop3(limit: 10)
        }
    }
}

#Preview {
    RankingView()
       
}
