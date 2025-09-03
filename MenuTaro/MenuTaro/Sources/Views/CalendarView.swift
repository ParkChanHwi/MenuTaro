//
//  CalendarView.swift
//  MenuTaro
//
//  Created by 장현준 on 9/2/25.
//

import SwiftUI
import SwiftData

private let hInset: CGFloat = 23
private struct TimelineRow: View {
    let title: String
        let category: String?
        let slotLabel: String
        let image: String

        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(slotLabel)
                        .font(.system(size: 13, weight: .medium, design: .default))
                        .foregroundColor(.gray)

                    HStack {
                        Text(title)
                            .font(.system(size: 17, weight: .medium, design: .default))
                            .foregroundStyle(.white)
                        if let category {
                            Text(category)
                                .font(.system(size: 12, weight: .medium, design: .default))
                                .padding(.horizontal, 10).padding(.vertical, 5)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Capsule())
                                .foregroundStyle(.white)
                        }
                    }
                }
                .padding(.horizontal, hInset)
                Spacer(minLength: 12)

                CalendarCardView(image: image)
            }
            .padding(.vertical, 8)
            
        }
    }

struct CalendarView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var vm = CalendarViewModel()
    @State private var date: Date = Date()
    let weekdays: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    private var formattedDate: String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let weekdayIndex = calendar.component(.weekday, from: date)
        let weekdaySymbol = weekdays[weekdayIndex - 1]
        return "\(day). \(weekdaySymbol)"
        
    }
    var body: some View {
        ZStack {
            VStack {
                DatePicker(
                    "날짜 선택",
                    selection: $date, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .environment(\.colorScheme, .dark)
                .accentColor(.orange)
                .tint(Color(red: 1, green: 0.29, blue: 0.14))
                .environment(\.locale, Locale(identifier: "ko_KR"))
                .onChange(of: date) {
                    vm.reload(for: date, context: modelContext)
                }
                HStack {
                    Text(formattedDate)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(Color(red: 1, green: 0.29, blue: 0.14))
                        .padding(.leading)
                    Spacer()
                }
                if vm.timelineItems.isEmpty {
                    VStack {
                        HStack {
                            Text("먹은 메뉴가 없습니다")
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                        .padding(.horizontal, hInset)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(vm.timelineItems) { item in
                                TimelineRow(
                                    title: item.title,
                                    category: item.category,
                                    slotLabel: item.slotLabel,
                                    image: item.image
                                )
                            }
                        }
                        .padding(.bottom, 24)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, hInset)
            
        }
        //전체 배경 색
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.07, green: 0.07, blue: 0.07), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.22, green: 0.22, blue: 0.22), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.96, y: 0),
                endPoint: UnitPoint(x: 0.03, y: 1)
            )
        )
        .background(.white)
        .onAppear {
            vm.reload(for: date, context: modelContext)
        }
    }
}

#Preview {
    CalendarView()
        .modelContainer(makePreviewContainer())
}
