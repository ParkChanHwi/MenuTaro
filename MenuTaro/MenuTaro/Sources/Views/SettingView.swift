import SwiftUI

struct SettingView: View {
    @EnvironmentObject private var router: Router
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
            VStack (alignment: .leading, spacing: 6) {
                Button {
                    router.push(.notiSetting)
                } label: {
                    Text("알림 설정")
                        .padding(10)
                }
                
                Button {
                    router.push(.settingsTerms(document: .serviceTerms))
                } label: {
                    Text("서비스 이용 약관")
                        .padding(10)
                }
                
                Button {
                    router.push(.settingsTerms(document: .privacyPolicy))
                } label: {
                    Text("개인정보 처리방침")
                        .padding(10)
                }

                Text("App version: 1.0.0")
                    .padding(10)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.gray)
            }
            .padding(.leading, -140)
            .padding(.bottom, 410)
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .medium))
    }
}

#Preview {
    SettingView()
}
