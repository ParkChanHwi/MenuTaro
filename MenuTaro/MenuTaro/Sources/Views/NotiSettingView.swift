import SwiftUI

struct NotiSettingView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var appNotiToggle = false
    @State private var nightAppNotiToggle = false
    
    // backButton 커스텀
    var backButton: some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
                    .aspectRatio(contentMode: .fill)
                    .fontWeight(.medium)
            }
        }
    }
    
    var body: some View {
                    
        VStack(alignment: .leading, spacing: 10) {
            Text("푸시 알림")
                .font(.system(size: 18, weight: .medium))
        
            Toggle("앱 알림", isOn: $appNotiToggle)
                .toggleStyle(SwitchToggleStyle(tint: Color.primaryRed))
            
            Toggle(isOn: $nightAppNotiToggle) {
                Text("야간 알림")
                    .font(.system(size: 16))
                + Text("(21시~08시)")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }
                .toggleStyle(SwitchToggleStyle(tint: Color.primaryRed))
        }
        .padding(.leading, 40)
        .padding(.trailing, 40)
        .padding(.bottom, 610)
        .navigationBarBackButtonHidden(true)
        
        // 상단 toolBar
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
            
            ToolbarItem(placement: .principal) {
                Text("알림 설정")
                    .font(.system(size: 18, weight: .semibold))
            }
        }

    }
}

#Preview {
    NotiSettingView()
}
