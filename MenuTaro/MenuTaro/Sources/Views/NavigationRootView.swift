//
//  NavigationRootView.swift
//  MenuTaro
//
//  Created by hwi on 10/1/25.
//

import SwiftUI
import SwiftData

struct NavigationRootView: View {
    @EnvironmentObject private var router: Router
    @Environment(\.modelContext) private var modelContext
    @State private var bgStyle: AppBackgroundView.Style = .black
    @State private var didSeedInitialData = false
    @StateObject private var onboarding = OnboardingFlowViewModel()
    @AppStorage("hasOnboarded") private var hasOnboarded = false
    @State private var didTriggerOnboarding = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            AppBackgroundView(style: bgStyle)

            NavigationStack(path: Binding(
                get: { router.path },
                set: { router.replace(with: $0) }
            )) {
                AppView()
                    .environmentObject(router)
                    .environmentObject(onboarding)
                    .navigationDestination(for: AppRoute.self) { route in
                        destination(for: route)
                    }
            }
        }
        .onPreferenceChange(BackgroundStylePreferenceKey.self) { style in
            guard bgStyle != style else { return }
            withAnimation(.easeInOut) { bgStyle = style }
        }
        .onAppear(perform: seedInitialDataIfNeeded)
        .onAppear(perform: showOnboardingIfNeeded)
        .onChange(of: hasOnboarded) { _, newValue in
            if newValue {
                didTriggerOnboarding = false
            } else {
                showOnboardingIfNeeded()
            }
        }
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
            
        case let .onboarding(step):
            onboardingDestination(for: step)
                .navigationBarBackButtonHidden()
        case .mypageEdit:
            MypageEditView()
                .environmentObject(router)
                .customToolbar(title: "프로필 편집") {
                    router.pop()
                }

        case let .MenuTaroSelected(foodId):
            MenuTaroSelectedContainer(foodId: foodId)
                .navigationTitle("메뉴 타로")
                .navigationBarTitleDisplayMode(.inline)
                .environmentObject(router)
            
        case .setting:
            SettingView()
                .navigationTitle("설정")
                .navigationBarTitleDisplayMode(.inline)
                .environmentObject(router)
        }
    }

    @ViewBuilder
    private func onboardingDestination(for step: OnboardingStep) -> some View {
        switch step {
        case .name:
            OnboardingNameSettingView()
                .environmentObject(router)
                .environmentObject(onboarding)
                .customToolbar(title: "", showBackButton: false) {
                }
        case .profile:
            OnboardingProfileCharacter()
                .environmentObject(router)
                .environmentObject(onboarding)
                .customToolbar(title: "") {
                    router.pop()
                }
        case .terms:
            OnboardingTermsView()
                .environmentObject(router)
                .environmentObject(onboarding)
                .customToolbar(title: "") {
                    router.pop()
                }
        }
    }
    
    @ViewBuilder
    private func snackFortuneDestination(for step: SnackFortuneStep) -> some View {
        switch step {
        case .selection:
            SnackTaro()
                .customToolbar(title: "포춘 쿠키") {
                    presentationMode.wrappedValue.dismiss()
                }
        case .opening:
            SnackTaro2()
                .customToolbar(title: "포춘 쿠키") {
                    presentationMode.wrappedValue.dismiss()
                }
        case .reveal:
            SnackTaro3()
                .customToolbar(title: "포춘 쿠키", showBackButton: false) {
                }
        case .result:
            SnackTaro4()
                .customToolbar(title: "포춘 쿠키", showBackButton: false) {
                }
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
    
    
    private func showOnboardingIfNeeded() {
        guard !hasOnboarded, !didTriggerOnboarding else { return }
        didTriggerOnboarding = true
        onboarding.reset()
        onboarding.preloadExistingUser(from: modelContext)
        router.replace(with: [.onboarding(step: .name)])
    }
}


#Preview {
    NavigationRootView()
        .environmentObject(Router())
        .modelContainer(makePreviewContainer())
}
