import SwiftUI

struct NotiSettingView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var appNotiToggle = false
    @State private var nightAppNotiToggle = false
    
    var body: some View {
                    
        VStack(alignment: .leading, spacing: 10) {
            Text("푸시 알림")
                .font(.system(size: 18, weight: .medium))
        
            NotificationPermissionToggleView()
            
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
        .customToolbar(title: "알림 설정") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    NotiSettingView()
}
