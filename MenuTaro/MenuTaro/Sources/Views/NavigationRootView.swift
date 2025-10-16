//
//  NavigationRootView.swift
//  MenuTaro
//
//  Created by hwi on 10/1/25.
//

import SwiftUI
import SwiftData

import SwiftUI
import SwiftData

struct NavigationRootView: View {
    @EnvironmentObject private var router: Router
    @Environment(\.modelContext) private var modelContext
    @State private var bgStyle: AppBackgroundView.Style = .black
    @State private var didSeedInitialData = false

    var body: some View {
        NavigationStack(path: Binding(
            get: { router.path },
            set: { router.replace(with: $0) }   
        )) {
            AppView()
                .environmentObject(router)
                .navigationDestination(for: AppRoute.self) { route in
                    destination(for: route)
                }
        }
        .background { AppBackgroundView(style: bgStyle) }
        .onPreferenceChange(BackgroundStylePreferenceKey.self) { style in
            guard bgStyle != style else { return }
            withAnimation(.easeInOut) { bgStyle = style }
        }
        .onAppear(perform: seedInitialDataIfNeeded)
        .preferredColorScheme(.dark)
    }

    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
        case let .bookmarkList(category):
            BookmarkView(category: category)
                .navigationTitle(category?.rawValue ?? "북마크")
                .navigationBarTitleDisplayMode(.inline)

        case let .snackFortune(step):
            snackFortuneDestination(for: step)

        case .menuTaro:
            MenuTaroView()
                .navigationTitle("메뉴 타로")
                .navigationBarTitleDisplayMode(.inline)
                .environmentObject(router)

        case let .MenuTaroSelected(foodId):
            MenuTaroSelectedContainer(foodId: foodId)
                .navigationTitle("메뉴 타로")
                .navigationBarTitleDisplayMode(.inline)
                .environmentObject(router)
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

extension NavigationRootView {
    @MainActor
    private func seedInitialDataIfNeeded() {
        guard !didSeedInitialData else { return }
        didSeedInitialData = true

        var descriptor = FetchDescriptor<FoodCard>()
        descriptor.fetchLimit = 1

        let existing = (try? modelContext.fetch(descriptor)) ?? []
        guard existing.isEmpty else { return }

        for seed in AppSeedData.foodCards {
            modelContext.insert(seed.makeModel())
        }

        do { try modelContext.save() }
        catch {
            #if DEBUG
            print("Failed to seed initial data: \(error)")
            #endif
        }
    }
}


#Preview {
    NavigationRootView()
        .environmentObject(Router())
        .modelContainer(makePreviewContainer())
}
