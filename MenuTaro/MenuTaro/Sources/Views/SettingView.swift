import SwiftUI

struct SettingView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // backButton 커스텀
    var backButton: some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.white)
                    .aspectRatio(contentMode: .fill)
                    .fontWeight(.medium)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 6) {
                Text("공지사항")
                    .padding(10)
                    .font(.system(size: 20, weight: .bold))
                NavigationLink(destination: NotiSettingView()) {
                    Text("알림 설정")
                        .padding(10)
                }
                NavigationLink(destination: SettingsTermsView(document: .serviceTerms)) {
                    Text("서비스 이용 약관")
                        .padding(10)
                }
                NavigationLink(destination: SettingsTermsView(document: .privacyPolicy)) {
                    Text("개인정보 처리방침")
                        .padding(10)
                }
                Text("App version: Beta")
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
}

#Preview {
    SettingView()
}
