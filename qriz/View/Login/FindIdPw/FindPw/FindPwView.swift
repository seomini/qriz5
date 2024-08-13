//
//  FindPwView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/30.
//

import SwiftUI

struct FindPwView: View {
    @EnvironmentObject var pathModel: PathModel
    @StateObject var findPwViewModel = FindPwViewModel()
    //    @State private var isButtonClicked = false
    @State private var showEmailSentAlert = false
    
    var body: some View {
        ZStack {
            Color.customBackground.edgesIgnoringSafeArea(.all)
            VStack{
                
                PwTitleView()
                
                IdEmailView(email: $findPwViewModel.email, errorMessage: findPwViewModel.errorMessage)
                    .onChange(of: findPwViewModel.email) { _ in
                        findPwViewModel.validateEmail()
                    }
                SendEmailButton(onSuccess: {
                    showEmailSentAlert = true
                })
            }
            .overlay(
                showEmailSentAlert ? AnyView(
                    CustomSendEmailView(
                        title: "이메일 발송 완료!",
                        subtitle: "입력해주신 이메일 주소로 아이디가 발송되었\n습니다. 메일함을 확인해주세요.",
                        onDismiss: {
                            showEmailSentAlert = false
                        }
                    )
                ) : AnyView(EmptyView())
            )
            .navigationTitle("아이디 찾기")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton()
                }
            }
        }
    }
}
// MARK: IDTitleView
struct PwTitleView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Spacer().frame(height: 40)
                
                Text("비밀번호를 잊으셨나요?")
                    .foregroundColor(.black)
                    .font(.system(size: 25, weight: .bold))
                Spacer().frame(height: 10)
                Text("기존에 가입할때 사용한 이메일을 입력하시면\n비밀번호 뵨굥 메일을 전송해드립니다.")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
            }
            .padding()
            Spacer()
        }
    }
}

// MARK: 이메일 입력 뷰
private struct IdEmailView: View {
    @Binding var email: String
    var errorMessage: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("이메일")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.bottom, 5)
            TextField("예) Qriz@test.com", text: $email)
                .padding()
                .foregroundColor(Color.customSignTfTk)
                .background(Color.customSignTfBg)
                .cornerRadius(5.0)
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.gray)
                    .font(.caption)
                    .padding(.top, 5)
            }
        }
        .padding()
    }
}

#Preview {
    FindPwView()
}
