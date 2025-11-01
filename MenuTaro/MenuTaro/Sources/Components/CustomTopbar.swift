import SwiftUI

// NavigationStack에 쌓여있지 않은 화면에서 사용 (뒤로가기 버튼 필요 X)
struct customTopbar: View {
    var title: String
    
    var body: some View {
         Text(title)
            .font(.system(size: 18, weight: .semibold))
            .padding(.bottom, 10)
    }
}
