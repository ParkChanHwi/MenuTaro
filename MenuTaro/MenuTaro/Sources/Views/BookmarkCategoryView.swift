//
//  BookmarkCategoryView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/23/25.
//

import SwiftUI

struct BookmarkCategoryListView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var router: Router
    @StateObject private var viewModel = BookmarkCategoryViewModel()
    
    let categories: [FoodCard.FoodCategory] = [.korean, .japanese, .chinese, .western, .etc]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                customTopbar(title: "북마크")
                // 모든 메뉴 (전용 카드)
                Button{
                    router.push(.bookmarkList( category: nil))
                } label: {
                    AllMenuCardView(
                        title: "모든 메뉴",
                        imageName: "FoodCategory_totalMenu",
                        count: viewModel.totalCount,
                        isActive: viewModel.totalCount > 0
                    )
                }
                .buttonStyle(.plain)
                .disabled(viewModel.totalCount == 0)

                
                // 일반 카테고리
                ForEach(categories, id: \.self) { category in
                    let count = viewModel.categoryCounts[category] ?? 0
                    Button{
                        router.push(.bookmarkList( category: category))
                    } label : {
                        CategoryCardView(
                            title: category.rawValue,
                            imageName: categoryImageName(category),
                            count: count,
                            isActive: count > 0
                        )
                    }
                    .buttonStyle(.plain)
                    .disabled(count == 0)
                }
            }

            .padding()
        }
        .onAppear {
            viewModel.setContext(context)
        }
    }
    
    private func categoryImageName(_ category: FoodCard.FoodCategory) -> String {
        switch category {
        case .korean: return "FoodCategory_Korean"
        case .japanese: return "FoodCategory_Japanese"
        case .chinese: return "FoodCategory_Chinese"
        case .western: return "FoodCategory_Western"
        case .etc: return "etc_food"
        }
    }
}


#Preview {
    BookmarkCategoryListView()
        .environmentObject(Router())
        .modelContainer(makePreviewContainer())
}
