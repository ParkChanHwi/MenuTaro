//
//  ConsentRow.swift
//  MenuTaro
//
//  Created by mac mini on 10/29/25.
//
import SwiftUI

struct ConsentRow: View {
    let item: ConsentItem
    let toggle: () -> Void
    let showDetail: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            CheckIcon(isOn: item.isOn)
                .onTapGesture(perform: toggle)
            
            Text(item.title)
                .font(.system(.subheadline, weight: .semibold))
                .foregroundStyle(.white)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture(perform: toggle)
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.white.opacity(0.7))
                .onTapGesture(perform: showDetail)
        }
        .padding(.horizontal, 14)
        .frame(height: 48)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.clear)
        )
        .contentShape(Rectangle()) // 행 전체 터치
    }
}
