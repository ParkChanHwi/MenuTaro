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
            
            // 추후 기능 추가 할 예정
//            Toggle(isOn: $nightAppNotiToggle) {
//                Text("마케팅 수신 동의")
//                    .font(.system(size: 16))
//            }
                .toggleStyle(SwitchToggleStyle(tint: Color.primaryRed))
        }
        .padding(.leading, 40)
        .padding(.trailing, 40)
        .padding(.bottom, 610)
    }
}

#Preview {
    NotiSettingView()
}
