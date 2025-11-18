//
//  OnboardingTermsView.swift
//  MenuTaro
//
//  Created by mac mini on 10/29/25.
//

import SwiftUI
import SwiftData

struct OnboardingTermsView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var onboarding: OnboardingFlowViewModel
    @Environment(\.modelContext) private var modelContext
    @StateObject private var vm = OnboardingTermsViewModel()
    @State private var errorMessage: String?

    var body: some View {
        GeometryReader { proxy in
            let metrics = MenuTaroLayoutMetrics.metrics(for: proxy.size)
            
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("3/3")
                        .font(.system(.subheadline, weight: .bold))
                        .foregroundColor(.primaryRed)
                        .padding(.leading, proxy.size.width * 0.1)

                    Text("주의 사항을\n확인해주세요.")
                        .font(.system(.title, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.leading, proxy.size.width * 0.1)

                    Text("*앱을 지우면 기록이 사라지니 주의해주세요!")
                        .font(.system(.caption, weight: .regular))
                        .foregroundColor(.white)
                        .padding(.leading, proxy.size.width * 0.1)


                 
                    VStack(spacing: 6) {
                        ForEach(vm.items) { item in
                            ConsentRow(
                                item: item,
                                toggle: { vm.toggle(item) },
                                showDetail: { vm.showDetail(for: item) }
                            )
                        }
                    }
                    .padding(.horizontal, metrics.horizontalPadding)
                    .padding(.top, metrics.componentSpacing + proxy.size.height * 0.48)

                    .padding(.bottom, metrics.callToActionHeight + metrics.orangeButtonBottomInset)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(spacing: 12) {
                     if let errorMessage {
                         Text(errorMessage)
                             .font(.system(.footnote, weight: .medium))
                             .foregroundColor(.primaryRed)
                     }

                     Button("시작하기") {
                         startApp()
                     }
                     .appFont(20, weight: .bold)
                     .frame(height: metrics.callToActionHeight)
                     .buttonStyle(OrangeButtonStyle())
                     .disabled(!vm.canStart)
                     .opacity(vm.canStart ? 1 : 0.5)
                }
                .padding(.horizontal, metrics.horizontalPadding)
                .padding(.bottom, metrics.orangeButtonBottomInset)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
        }
        .background(Color.black)
        .sheet(item: detailSheetBinding) { _ in
                TermsAndConditions()
        }
    }
    
}


private extension OnboardingTermsView {
    var detailSheetBinding: Binding<ConsentItem?> {
        Binding(
            get: {vm.detailItem},
            set: {vm.detailItem = $0}
        )
    }
    
    func startApp() {
        do {
            try onboarding.complete(using: modelContext)
            errorMessage = nil
            router.popToRoot()
            router.select(tab: .home)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}


#Preview {
    OnboardingTermsView()
        .environmentObject(Router())
        .environmentObject(OnboardingFlowViewModel())
        .modelContainer(makePreviewContainer())
}
