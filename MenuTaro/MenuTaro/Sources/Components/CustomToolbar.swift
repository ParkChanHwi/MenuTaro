import SwiftUI

// NavigationStack으로 이동한 View에 사용
struct CustomToolbar: ViewModifier {
    var title: String
    var onBack: (() -> Void)?
    var showBackButton: Bool = true
    
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
            }
    }
}

extension View {
    func customToolbar(title: String, showBackButton: Bool = true, onBack: (() -> Void)? = nil) -> some View {
        self.modifier(CustomToolbar(title: title, onBack: onBack, showBackButton: showBackButton))
    }
}
