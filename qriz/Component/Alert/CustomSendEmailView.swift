import SwiftUI

struct CustomSendEmailView: View {

    var title: String
    var subtitle: String
    var onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 20) {
                Text(title)
                    .font(.headline)
                    .padding([.top, .leading, .trailing])

                Text(subtitle)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .trailing, .bottom])

                Button(action: onDismiss) {
                    Text("확인")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                .padding([.leading, .trailing, .bottom])
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 10)
            .padding()
        }
    }
}

#Preview {
    CustomSendEmailView(
        title: "이메일 발송 완료!",
        subtitle: "입력해주신 이메일 주소로 아이디가 발송되었\n습니다. 메일함을 확인해주세요.",
        onDismiss: {}
    )
}
