//
//  RadialLayoutView.swift
//  MenuTaro
//
//  Created by 박찬휘 on 9/8/25.
//

import SwiftUI

struct RadialLayoutView<Content: View, Item: RandomAccessCollection, ID: Hashable>: View where Item.Element: Identifiable {
    @StateObject private var viewModel = RadialLayoutViewModel<Item.Element, ID>()

    // Data & config
    var items: Item
    var id: KeyPath<Item.Element, ID>
    var spacing: CGFloat? = nil
    var dropTargetRect: CGRect? = nil

    // UI content builder
    var content: (Item.Element, Int, CGFloat) -> Content

    // Events 
    var onIndexChange: ((Int) -> Void)? = nil
    var onCardSelected: ((Item.Element) -> Void)? = nil

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let countInt = max(items.count, 1) // 0 방어
            let count = CGFloat(countInt)
            let spacing = spacing ?? 0
            let viewSize = (width - spacing) / (count / 2)
            let radius = (width - viewSize) / 2

            ZStack {
                // 링 레이어 (회전 제스처)
                ringLayer(width: width, count: count, viewSize: viewSize, radius: radius)
                    .rotationEffect(viewModel.dragRotation)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                guard viewModel.selectedCardID == nil else { return }
                                let progress = value.translation.width / max(viewSize * 2, 1) // 0 방어
                                let rotationFraction = 360.0 / max(count, 1)
                                viewModel.dragRotation = .degrees(
                                    rotationFraction * progress + viewModel.lastDragRotation.degrees
                                )
                                viewModel.calculateIndex(count: count)
                                onIndexChange?(viewModel.activeIndex)
                            }
                            .onEnded { _ in
                                guard viewModel.selectedCardID == nil else { return }
                                viewModel.lastDragRotation = viewModel.dragRotation
                            }
                    )

                // 선택된 카드 오버레이 (정방향)
                if let item = viewModel.selectedItem,
                   let start = viewModel.pickStartPoint {
                    content(item, fetchIndex(item), viewSize)
                        .frame(width: viewSize, height: viewSize)
                        .scaleEffect(1.08)
                        .shadow(radius: 10)
                        .position(start)
                        .offset(viewModel.dragOffset)
                        .zIndex(50)
                        .highPriorityGesture(
                            DragGesture()
                                .onChanged { drag in
                                    viewModel.dragOffset = drag.translation
                                }
                                .onEnded { drag in
                                    let layoutOrigin = geo.frame(in: .global).origin
                                    if viewModel.checkDrop(start, drag.translation,
                                                           layoutOrigin: layoutOrigin,
                                                           dropRect: dropTargetRect) {
                                        viewModel.droppedItem = item
                                        onCardSelected?(item)
                                    }
                                    viewModel.resetSelection()
                                }
                        )
                }
            }
            .frame(width: width, height: width)
        }
    }

    // MARK: - Ring layer
    private func ringLayer(width: CGFloat, count: CGFloat, viewSize: CGFloat, radius: CGFloat) -> some View {
        ZStack {
            ForEach(items, id: id) { item in
                let idx = fetchIndex(item)
                let itemID = item[keyPath: id]
                let rotation = (CGFloat(idx) / max(count, 1)) * 360.0
                let isHidden = (viewModel.selectedCardID == itemID)

                if !isHidden {
                    content(item, idx, viewSize)
                        .frame(width: viewSize, height: viewSize)
                        .rotationEffect(.degrees(90))
                        .offset(x: radius)
                        .rotationEffect(.degrees(rotation))
                        .onLongPressGesture(minimumDuration: 0.3) {
                            viewModel.selectedCardID = itemID
                            viewModel.selectedItem = item
                            viewModel.dragOffset = .zero
                            viewModel.pickStartPoint = viewModel.calculateStartPoint(
                                width: width, radius: radius, rotation: rotation
                            )
                        }
                }
            }
        }
    }

    // MARK: - Utilities
    private func fetchIndex(_ item: Item.Element) -> Int {
        for (i, el) in items.enumerated() {
            if el[keyPath: id] == item[keyPath: id] { return i }
        }
        return 0
    }
}



#Preview {
    MenuTaroView()
        .modelContainer(makePreviewContainer())
}
