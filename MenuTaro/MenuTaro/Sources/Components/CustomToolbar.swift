import SwiftUI

// NavigationStack으로 이동한 View에 사용
struct CustomToolbar: ViewModifier {
    @EnvironmentObject private var router: Router
    var title: String
    var onBack: (() -> Void)?
    var showBackButton: Bool = true
    var showGearButton: Bool = false
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                if showBackButton {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            onBack?()
                        } label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.white)
                                    .aspectRatio(contentMode: .fill)
                                    .fontWeight(.medium)
                            }
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.system(size: 18, weight: .semibold))
                }
                if showGearButton {
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        Button {
                                            router.push(.setting)
                                        } label: {
                                            HStack {
                                                Image(systemName: "gearshape")
                                                    .font(.system(size: 13))
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    }
                                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
    }
}

extension View {
    func customToolbar(title: String, showBackButton: Bool = true, showGearButton: Bool = false, onBack: (() -> Void)? = nil) -> some View {
        self.modifier(CustomToolbar(title: title, onBack: onBack, showBackButton: showBackButton, showGearButton: showGearButton))
    }
}
