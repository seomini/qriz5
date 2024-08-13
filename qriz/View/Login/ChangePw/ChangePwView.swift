//
//  ChangePwView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/06/04.
//

import SwiftUI

struct ChangePwView: View {
    @StateObject private var changePwViewModel = ChangePwViewModel()
    @EnvironmentObject private var pathModel: PathModel
    @State private var showEmailSentAlert = false
    
    var body: some View {
        ZStack {
            Color.customBackground.edgesIgnoringSafeArea(.all)
            VStack {
                
                Spacer().frame(height: 20)
                
                ChangePwTitleView()
                
                Spacer().frame(height: 20)
                
                ChangePwTextFieldView(changePwViewModel: changePwViewModel)
                
                Spacer()
                
                ChangePwOkButtonView {
                    changePwViewModel.changePassword()
                    if changePwViewModel.errorMessage == nil {
                        showEmailSentAlert = true
                    }
                }
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton()
                }
            }
            
            if showEmailSentAlert {
                CustomSendEmailView(
                    title: "비밀번호 변경 완료!",
                    subtitle: "비밀번호가 성공적으로 변경되었습니다. 로그인 화면으로 돌아가 로그인하세요.",
                    onDismiss: {
                        showEmailSentAlert = false
                    }
                )
                .transition(.opacity)
                .zIndex(1)
            }
        }
    }
}

//MARK: ChangePwTitleView
struct ChangePwTitleView: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 5) {
            
                Text("소중한 정보를 보호하기위헤\n새로운 비밀번호로 변경해 주세요.?")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold))
                
                Spacer().frame(height: 10)
                
                Text("이전에 사용한 적 없는 비밀번호가 안전합니다.")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
            }
            .padding()
            
            Spacer()
        }
    }
}

//MARK: ChangePwTextFieldView
struct ChangePwTextFieldView: View {
    @ObservedObject var changePwViewModel: ChangePwViewModel

    var body: some View {
        VStack(alignment: .leading) {

            SecureField("현재 비밀번호", text: $changePwViewModel.newPassword)
                .padding()
                .foregroundColor(Color.customSignTfTk)
                .background(Color.customSignTfBg)
                .cornerRadius(5.0)
            SecureField("새 비밀번호", text: $changePwViewModel.newPassword)
                .padding()
                .foregroundColor(Color.customSignTfTk)
                .background(Color.customSignTfBg)
                .cornerRadius(5.0)
            Text("새 비밀번호를 입력해주세요(영문,숫자,특수문자8~20자)")
                .font(.system(size: 11))
                .foregroundColor(Color.customSignTc)
                .padding(.top,5)
                .padding(.bottom,5)
            SecureField("새 비밀번호 확인", text: $changePwViewModel.confirmPassword)
                .padding()
                .foregroundColor(Color.customSignTfTk)
                .background(Color.customSignTfBg)
                .cornerRadius(5.0)

            if let errorMessage = changePwViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.gray)
                    .font(.caption)
                    .padding(.top, 5)
            }
        }
        .padding([.leading, .trailing, .bottom])
    }
}

//MARK: ChangePwOkButtonView
struct ChangePwOkButtonView: View {
    var onConfirm: () -> Void
    
    var body: some View {
        Button(action: {
            onConfirm()
        }) {
            Text("확인")
                .foregroundColor(Color.customSignTk)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.customSignBg)
                .cornerRadius(10)
        }
        .padding([.leading, .trailing, .bottom])
    }
}

#Preview {
    ChangePwView()
}
