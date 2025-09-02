//
//  MenuTaroView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/27/25.
//
import SwiftUI
import SwiftData

struct MenuTaroView: View {
    @State private var cards = Array(0..<20) // 카드 번호 리스트
    @State private var angle: Double = 0.0   // 전체 회전각
    @State private var draggingIndex: Int? = nil // 드래그 중인 카드 인덱스
    @State private var dragOffset: CGSize = .zero
    @State private var selectedIndex: Int? = nil // 선택된 카드 인덱스

    let radius: CGFloat = 200
    let cardSize = CGSize(width: 80, height: 120)

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 원형 카드 배치
                ForEach(cards, id: \.self) { i in
                    let idx = cards.firstIndex(of: i)!
                    let step = 2 * .pi / Double(cards.count)
                    let theta = step * Double(idx) + angle // angle은 각 아이템 사이의 간격
                    let x = cos(theta) * radius
                    let y = sin(theta) * radius

                    let isDragging = draggingIndex == i

                    Image("card_back_taro")
                        .resizable()
                        .frame(width: cardSize.width, height: cardSize.height)
                        .rotationEffect(.degrees(theta * 180 / .pi + 90))
                        .position(
                            x: geometry.size.width / 2 + CGFloat(x),
                            y: geometry.size.height * 1.20 + CGFloat(y)
                        )
                        .offset(isDragging ? dragOffset : .zero)
                        .zIndex(isDragging ? 1 : 0)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    draggingIndex = i
                                    dragOffset = value.translation
                                }
                                .onEnded { value in
                                    if value.translation.height < -100 {
                                        // 위로 충분히 드래그 → 카드 선택
                                        withAnimation {
                                            selectedIndex = i
                                            cards.removeAll { $0 == i }
                                            draggingIndex = nil
                                            dragOffset = .zero
                                        }
                                    } else {
                                        // 복귀
                                        withAnimation {
                                            draggingIndex = nil
                                            dragOffset = .zero
                                        }
                                    }
                                }
                        )
                }

                // 중앙에 선택된 카드 보여주기 (기존 위치로 이동)
                if let selected = selectedIndex {
                      VStack(spacing: 8) {
                          Text("선택된 카드 인덱스: \(selected)")
                              .foregroundColor(.gray)
                              .font(.caption)
  
                          Image("CardBack")
                              .resizable()
                              .frame(width: 120, height: 180)
                              .overlay(
                                  RoundedRectangle(cornerRadius: 10)
                                      .stroke(Color.yellow, lineWidth: 4)
                              )
                              .shadow(radius: 10)
                              .transition(.scale)
                              .zIndex(10)
                      }
                      .position(
                          x: geometry.size.width / 2,
                          y: geometry.size.height * 0.45
                      )
                      .onTapGesture {
                          withAnimation {
                              selectedIndex = nil
                          }
                      }
                } else {
                    // 디버깅용 상단 인덱스 표시 + 카드 안내 영역
                    VStack(spacing: 8) {
                        Text("선택된 카드 인덱스: 없음")
                            .foregroundColor(.gray)
                            .font(.caption)

                        RoundedRectangle(cornerRadius: 8)
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                            .foregroundColor(.gray)
                            .frame(width: 130, height: 190)
                            .overlay(
                                Text("카드를 이곳에 올려주세요")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            )
                    }
                    .position(
                        x: geometry.size.width / 2,
                        y: geometry.size.height * 0.45
                    )
                    .zIndex(5)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        angle += Double(value.translation.width / 300)
                    }
            )
        }
    }
}

#Preview {
    MenuTaroView()
}
