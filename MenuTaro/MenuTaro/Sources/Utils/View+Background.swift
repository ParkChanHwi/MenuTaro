//
//  View+Background.swift
//  MenuTaro
//
//  Created by 박찬휘 on 8/14/25.
//

import SwiftUI

extension View {
    func appBackground() -> some View {
        self
            .background(Color(.black))
            .ignoresSafeArea()
    }
    
}
