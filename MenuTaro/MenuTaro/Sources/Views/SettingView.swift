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
                Text("버그 신고")
                    .padding(10)
                Text("고객센터/문의하기")
                    .padding(10)
                Text("약관 및 개인정보 처리방침")
                    .padding(10)
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
            
            ToolbarItem(placement: .principal) {
                Text("설정")
                    .font(.system(size: 18, weight: .semibold))
            }
        }
    }
}

#Preview {
    SettingView()
}
