//
//  MypageView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/13/25.
//

import SwiftUI
import SwiftData

private let hInset: CGFloat = 13

struct MypageView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var vm = MypageViewModel()

    var body: some View {
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        ZStack {
                            LinearGradient(
                                colors: [Color(red: 1, green: 0.29, blue: 0.14),
                                         Color(red: 0.13, green: 0.13, blue: 0.13).opacity(0.8)],
                                startPoint: .top, endPoint: .bottom
                            )
                            .clipShape(Circle())
                            
                            Image("chicken")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                        }
                        .frame(width: 120, height: 120)
                        .padding(.leading, 22)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, minHeight: 153)
                    .background(Color.white.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Text("프로필 편집")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 47)
                        .background(Color(red: 1, green: 0.29, blue: 0.14))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    HStack {
                        Text("7월 랭킹")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                        HStack(spacing: 4) {
                            Text("전체보기")
                                .font(.system(size: 12, weight: .regular, design: .default))
                                .foregroundColor(.gray)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    HStack {
                        Text("메뉴 랭킹")
                            .font(.system(size: 14, weight: .medium, design: .default))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 15) {
                            ForEach(vm.menuTop3, id: \.mypageId) { mp in
                                MypageCardView(mypage: mp)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                    
                    HStack {
                        Text("간식 랭킹")
                            .font(.system(size: 14, weight: .medium, design: .default))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 15) {
                            ForEach(vm.menuTop3, id: \.mypageId) { mp in
                                MypageCardView(mypage: mp)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, hInset)
                .padding(.top, 13)
            }
        .onAppear { vm.setContext(context) }
    }
}

#Preview {
    MypageView()
        .modelContainer(makePreviewContainer())
}
