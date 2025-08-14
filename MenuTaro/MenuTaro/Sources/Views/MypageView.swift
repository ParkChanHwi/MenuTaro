//
//  MypageView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/13/25.
//

import SwiftUI

struct MypageView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                ZStack {
                    Text("마이페이지")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                    Image(systemName: "gearshape")
                        .foregroundColor(.white)
                        .offset(x: 175)
                }
                .padding(.bottom, 29.21)
                ZStack {
                    HStack {
                        ZStack {
                            Image("chicken")
                                .resizable()
                                .frame(width: 170, height: 170)
                                .clipped()
                                .offset(y: 10)
                        }
                        .frame(width: 120, height: 120)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 1, green: 0.29, blue: 0.14), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.13, green: 0.13, blue: 0.13).opacity(0.8), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                            )
                        .cornerRadius(75)
                        .padding(.leading, 22)
                        Spacer()    //왼쪽정렬
                        Text("이병이병건이병이병건님 오늘도 행운이 가득하세요!")
                            .frame(width: 170)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .offset(x: -40, y: -30)
                    }
                }
                .frame(width: 362, height: 153)
                .background(Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0.15))
                .cornerRadius(20)
                Text("프로필 편집")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                .frame(width: 362, height: 47)
                .background(Color(red: 1, green: 0.29, blue: 0.14))
                .cornerRadius(10)
                .padding(.top, 20)
                HStack {
                    Text("7월 랭킹")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                    Spacer()
                    HStack {
                        Text("전체보기")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.gray)
                            .offset(x: 5)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 19)
                }
                .padding(.top, 23)
                HStack {
                    Text("메뉴 랭킹")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.leading, 25.26)
                        .padding(.top, 13)
                    Spacer()
                }
                //수평 스크롤뷰
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<3) { _ in
                            rankCard
                        }
                        .padding(.trailing, 15)
                    }
                    .padding(.leading, 30.26)
                    .padding(.top, 21)
                }
                HStack {
                    Text("간식 랭킹")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.leading, 25.26)
                        .padding(.top, 17.79)
                    Spacer()
                }
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<3) { _ in
                            rankCard
                        }
                        .padding(.trailing, 15)
                    }
                    .padding(.leading, 30.26)
                    .padding(.top, 21)
                }
                Spacer()
                }
            }
        }
    //임시 네모카드(음식 데이터)
    var rankCard: some View {
        Rectangle()
            .fill(Color.gray)
            .frame(width: 139.95021, height: 139.95021)
            .cornerRadius(12)
    }
    }


#Preview {
    MypageView()
}
