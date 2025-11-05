//
//  BookmarkView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/11/25.
//
import SwiftUI
import SwiftData

struct BookmarkView: View {
    @Environment(\.modelContext) private var context
    
    var category: FoodCard.FoodCategory?
    
    // StateObject 대신 ObservedObject 사용하고 init에서 ViewModel 생성
    @ObservedObject private var viewModel: BookmarkViewModel
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 2)
    
    init(category: FoodCard.FoodCategory? = nil) {
        self.category = category
        self.viewModel = BookmarkViewModel(category: category) // 카테고리 전달
    }
    
    var body: some View {
        VStack {
            if viewModel.bookmarks.isEmpty {
                emptyStateView
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 13) {
                        ForEach(viewModel.bookmarks, id: \.bookmarkId) { bookmark in
                            BookmarkCardView(bookmark: bookmark)
                        }
                    }
                    .padding(.horizontal, 13)
                    .padding(.top, 13)
                }
            }
        }
        .onAppear {
            viewModel.setContext(context)
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 13) {
            Spacer()
            Image(systemName: "bookmark")
                .font(.system(size: 60))
                .foregroundColor(.gray.opacity(0.5))
            Text("북마크 항목이 비어있습니다.")
                .font(.system(size: 18))
                .foregroundColor(.gray.opacity(0.5))
            Spacer()
        }
    }
}

#Preview {
    BookmarkView()
        .modelContainer(makePreviewContainer())
}
