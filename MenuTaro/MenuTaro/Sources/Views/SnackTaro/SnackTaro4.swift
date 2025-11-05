import SwiftUI

struct SnackTaro4: View {
    // 버튼 상태
    @State private var isBookmared = false
    
    @EnvironmentObject private var router: Router
    var body: some View {
        VStack(spacing:32) {
            VStack {
                Text("이번 간식은")
                    .font(.system(size: 22, weight: .semibold))
                Text("아이스크림")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.primaryRed)
                
                cookieCircle(imageName: "ice", width: 285, height: 285)
                    .padding(.vertical, 85)
            }
            .offset(y: 40)
            
            VStack {
                Button {
                    isBookmared.toggle()
                } label: {
                    HStack {
                        Text("이 메뉴카드 저장")
                            .font(.system(size: 14))
                        Text(Image(systemName: isBookmared ? "bookmark.fill" : "bookmark"))
                    }
                }
                .foregroundColor(.primaryRed)
                .frame(width: 153, height: 41)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.primaryRed, lineWidth: 1)
                )
                Button {
                    router.popToRoot()
                } label: {
                    Text("이 메뉴 먹을게요")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color("buttonOrange"))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, -10)
            }
            
            Button {
                router.pop(to: .snackFortune(step:.selection))
            }label: {
                Text("다시 뽑을래요")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.gray)
                    .clipShape(Capsule())
            }
        }
    }
}

#Preview {
    SnackTaro4()
        .environmentObject(Router())
}
