//
//  Constants.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/9/25.
//  코드 출처 : https://riu-dev.tistory.com/18
//  변경 사항 : Figma 디자인 기준 크기 iPhone14 -> iPhone16 Pro


import Foundation
import UIKit

struct Constants {
    static let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    static let screenWidth = windowScene?.screen.bounds.width ?? 0
    static let screenHeight = windowScene?.screen.bounds.height ?? 0
    
    // Figma 디자인 기준 크기
    static let baseScreenWidth: CGFloat = 402
    static let baseScreenHeight: CGFloat = 874
    
    // 현재 디바이스 대비 비율
    static let ControlWidth = screenWidth / baseScreenWidth
    static let ControlHeight = screenHeight / baseScreenHeight
}


