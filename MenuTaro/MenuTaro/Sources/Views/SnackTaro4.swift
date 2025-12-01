import SwiftUI

struct SnackTaro4: View {
    // 버튼 상태
    @State private var isBookmared = false

    @EnvironmentObject private var router: Router
    @EnvironmentObject private var viewModel: SnackTaroViewModel
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        let snackName = viewModel.selectedSnack?.name ?? "간식을 불러오지 못했어요"
        let snackImage = viewModel.selectedSnack?.image ?? "cookie_snack"

        VStack(spacing:32) {
            VStack {
                Text("이번 간식은")
                    .font(.system(size: 22, weight: .semibold))
                Text(snackName)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.primaryRed)

                snackCircle(imageName: snackImage, width: 260, height: 260)
                    .padding(.vertical, 20)
            }
            .offset(y: 40)
            
            VStack {
                Button {
                    viewModel.logConsumptionIfNeeded()
                    router.popToRoot()
                } label: {
                    Text("이 간식 먹을게요")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color("buttonOrange"))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
            
            Button {
                viewModel.startNewFortune()
                router.pop(to: .snackFortune(step:.selection))
            }label: {
                Text("다시 뽑을래요")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.gray)
                    .clipShape(Capsule())
            }
        }
        .onAppear {
            viewModel.setContext(modelContext)
        }
    }
}

#Preview {
    SnackTaro4()
        .environmentObject(Router())
}
