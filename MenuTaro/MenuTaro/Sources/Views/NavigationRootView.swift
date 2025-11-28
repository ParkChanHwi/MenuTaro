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
    @StateObject private var snackFortuneViewModel = SnackTaroViewModel()
    
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
            let categoryName = category?.rawValue ?? "북마크"
            
            BookmarkView(category: category)
                .customToolbar(title: categoryName) {
                    router.pop()
                }

        case let .snackFortune(step):
            snackFortuneDestination(for: step)

        case .menuTaro:
            MenuTaroView()
                .environmentObject(router)
                .customToolbar(title: "메뉴 타로") {
                    router.pop()
                }
                
            
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
                .environmentObject(router)
                .customToolbar(title: "메뉴 타로") {
                    router.pop()
                }
            
        case .setting:
            SettingView()
                .environmentObject(router)
                .customToolbar(title: "설정") {
                    router.pop()
                }
        
        case .ranking:
            RankingView()
                .environmentObject(router)
                .customToolbar(title: "전체 랭킹") {
                    router.pop()
                }
            
        case .calendar:
            CalendarView()
                .environmentObject(router)
                .customToolbar(title: "캘린더") {
                    router.pop()
                }
            
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
                    router.pop()
                }
                .environmentObject(snackFortuneViewModel)
        case .opening:
            SnackTaro2()
                .customToolbar(title: "포춘 쿠키") {
                    router.pop()
                }
                .environmentObject(snackFortuneViewModel)
        case .reveal:
            SnackTaro3()
                .customToolbar(title: "포춘 쿠키", showBackButton: false) {
                }
                .environmentObject(snackFortuneViewModel)
        case .result:
            SnackTaro4()
                .customToolbar(title: "포춘 쿠키", showBackButton: false) {
                }
                .environmentObject(snackFortuneViewModel)
        }
    }
}

extension NavigationRootView {
    @MainActor
    private func seedInitialDataIfNeeded() {
        guard !didSeedInitialData else { return }
        didSeedInitialData = true

        var descriptor = FetchDescriptor<FoodCard>()
        let existingCards = (try? modelContext.fetch(descriptor)) ?? []
        var didChange = false

        var existingFoodByName: [String: FoodCard] = [:]
        for card in existingCards {
            existingFoodByName[card.name] = card
        }
        
        for seed in AppSeedData.foodCards {
            if let card = existingFoodByName[seed.name] {
                if card.details != seed.details || card.category != seed.category || card.image != seed.image {
                    card.details = seed.details
                    card.category = seed.category
                    card.image = seed.image
                    didChange = true
                }
            } else {
                modelContext.insert(seed.makeModel())
                didChange = true
            }
        }

        var snackDescriptor = FetchDescriptor<Snack>()
        let existingSnacks = (try? modelContext.fetch(snackDescriptor)) ?? []
        var existingSnackByName: [String: Snack] = [:]
        for snack in existingSnacks {
            existingSnackByName[snack.name] = snack
        }

        for seed in AppSeedData.snacks {
            if let snack = existingSnackByName[seed.name] {
                if snack.image != seed.image {
                    snack.image = seed.image
                    didChange = true
                }
            } else {
                modelContext.insert(seed.makeModel())
                didChange = true
            }
        }
        
        guard didChange else { return }

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
