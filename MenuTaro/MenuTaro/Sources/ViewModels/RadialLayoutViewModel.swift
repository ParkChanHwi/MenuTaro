//
//  RadialLayoutViewModel.swift
//  MenuTaro
//
//  Created by 박찬휘 on 9/8/25.
//

import SwiftUI

final class RadialLayoutViewModel<Item: Identifiable, ID: Hashable>: ObservableObject {
    @Published var dragRotation: Angle = .zero
    @Published var lastDragRotation: Angle = .zero
    @Published var activeIndex: Int = 0

    @Published var selectedCardID: ID? = nil
    @Published var selectedItem: Item? = nil
    @Published var dragOffset: CGSize = .zero
    @Published var pickStartPoint: CGPoint? = nil

    // 내부적으로도 필요하면 활용 가능
    @Published var droppedItem: Item? = nil

    func calculateIndex(count: CGFloat) {
        guard count > 0 else { activeIndex = 0; return }
        var active = (dragRotation.degrees / 360.0 * count).rounded()
            .truncatingRemainder(dividingBy: count)
        active = active == 0 ? 0 : (active < 0 ? -active : count - active)
        self.activeIndex = Int(active)
    }

    func calculateStartPoint(width: CGFloat, radius: CGFloat, rotation: CGFloat) -> CGPoint {
        let rad = (rotation + dragRotation.degrees) * .pi / 180
        let center = CGPoint(x: width/2, y: width/2)
        return CGPoint(
            x: center.x + radius * cos(rad),
            y: center.y + radius * sin(rad)
        )
    }

    func checkDrop(_ start: CGPoint, _ drag: CGSize, layoutOrigin: CGPoint, dropRect: CGRect?) -> Bool {
        guard let dropRect else { return false }
        let endPointGlobal = CGPoint(
            x: layoutOrigin.x + start.x + drag.width,
            y: layoutOrigin.y + start.y + drag.height
        )
        return dropRect.contains(endPointGlobal)
    }

    func resetSelection(animated: Bool = true) {
        let reset = {
            self.selectedCardID = nil
            self.selectedItem = nil
            self.dragOffset = .zero
            self.pickStartPoint = nil
        }
        if animated {
            withAnimation(Animation.easeOut(duration: 0.2)) {
                reset()
            }
        } else {
            reset()
        }
    }   
}
