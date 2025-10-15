//
//  AppBackgroundView.swift
//  MenuTaro
//
//  Created by mac mini on 10/1/25.
//

import SwiftUI

struct AppBackgroundView: View {
    enum Style {
        case black
        case gradient
    }
    var style: Style = .gradient
    
    var body: some View {
        Group {
            switch style {
            case .black:
                Color.black.ignoresSafeArea()	
            case .gradient:
                LinearGradient (colors: [Color.black, Color("primaryRed").opacity(0.85)], startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all)
            }
        }
    }
}

#Preview {
    AppBackgroundView()
}
