//
//  NavigationRootView.swift
//  MenuTaro
//
//  Created by hwi on 10/1/25.
//

import SwiftUI

struct NavigationRootView: View {
    @EnvironmentObject private var router: Router
    @State private var bgStyle: AppBackgroundView.Style = .black
    var body: some View {
        ZStack {
            AppBackgroundView(style: bgStyle)
            NavigationStack(path: Binding(
                get: {router.path},
                set: {router.replace(with: $0)}
            )) {
                AppView()
                    .environmentObject(router)
                    .navigationDestination(for: AppRoute.self) { route in
                        destination(for: route)
                    }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    private func destination(for route: AppRoute) -> some View{
        switch route {
        case let .bookmarkList(category):
            BookmarkView(category: category)
                .navigationTitle(category?.rawValue ?? "북마크")
                .navigationBarTitleDisplayMode(.inline)
        case let .snackFortune(step):
            snackFortuneDestination(for: step)
        }
    }
    
    @ViewBuilder
    private func snackFortuneDestination(for step: SnackFortuneStep) -> some View {
        switch step {
        case .selection:
            SnackTaro()
                .navigationTitle("포춘 쿠키")
                .navigationBarTitleDisplayMode(.inline)
        case .opening:
            SnackTaro2()
                .navigationTitle("포춘 쿠키")
                .navigationBarTitleDisplayMode(.inline)
            
        case .reveal:
            SnackTaro3()
                .navigationBarBackButtonHidden()
                .navigationTitle("포춘 쿠키")
                .navigationBarTitleDisplayMode(.inline)
        case .result:
            SnackTaro4()
                .navigationBarBackButtonHidden()
                .navigationTitle("포춘 쿠키")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationRootView()
        .environmentObject(Router())
        .modelContainer(makePreviewContainer())
}
