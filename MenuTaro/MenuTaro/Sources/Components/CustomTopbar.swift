import SwiftUI

// NavigationStack에 쌓여있지 않은 화면에서 사용 (뒤로가기 버튼 필요 X)
struct customTopbar: View {
    @EnvironmentObject private var router: Router
    var title: String
    var showGearButton: Bool = false
    
    var body: some View {
        ZStack {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .padding(.bottom, 10)
                .foregroundColor(.white)
            HStack {
                Spacer()
                if showGearButton {
                    Button {
                        router.push(.setting)
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                    }
                }
            }
        }
    }
}
