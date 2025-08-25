//
//  BookmarkCategoryView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/23/25.
//

import SwiftUI

struct BookmarkCategoryListView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel = BookmarkCategoryViewModel()
    
    let categories: [FoodCard.FoodCategory] = [.korean, .japanese, .chinese, .western, .etc]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                // 모든 메뉴 (전용 카드)
                AllMenuCardView(
                    title: "모든 메뉴",
                    imageName: "FoodCategory_TotalMenu",
                    count: viewModel.totalCount,
                    isActive: viewModel.totalCount > 0
                )
                
                // 일반 카테고리
                ForEach(categories, id: \.self) { category in
                    let count = viewModel.categoryCounts[category] ?? 0
                    CategoryCardView(
                        title: category.rawValue,
                        imageName: categoryImageName(category),
                        count: count,
                        isActive: count > 0
                    )
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
        .modelContainer(makePreviewContainer())
}
