//
//  LoginView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var pathModel: PathModel
    @State private var isPresentedLoginView: Bool = false
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            LoginContentView(
                loginViewModel: LoginViewModel(),
                isPresentedLoginView: $isPresentedLoginView
            )
            .navigationDestination(
                for: PathType.self,
                destination: { PathType in
                    switch PathType {
                    case .signUpView:
                        SignUpView()
                            .navigationBarBackButtonHidden()
                    case .findIdView:
                        FindIdView()
                            .navigationBarBackButtonHidden()
                    case .findPwView:
                        FindPwView()
                            .navigationBarBackButtonHidden()
                    }
                }
            )
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isPresentedLoginView) {
                HomeView()
//                if loginViewModel.hasLoginRecord {
//                    HomeView()
//                } else {
//                    OnboardingFlowView()
//                }
            }
        }
        .environmentObject(pathModel)
    }
}

// MARK: -
private struct LoginContentView: View {
    @ObservedObject private var loginViewModel: LoginViewModel
    @Binding private var isPresentedLoginView: Bool
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    init(loginViewModel: LoginViewModel, isPresentedLoginView: Binding<Bool>) {
        self.loginViewModel = loginViewModel
        self._isPresentedLoginView = isPresentedLoginView
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer().frame(height: 100)
            
            LogoImageView()
            LoginButtonView(
                loginViewModel: loginViewModel,
                isPresentedLoginView: $isPresentedLoginView
            )
            SocialLoginButtonView()
            SignUpFindView()
            Spacer()
        }
        .padding(.top, 20)
        .edgesIgnoringSafeArea(.top)
        .background(Color.customBackground)
    }
}

// MARK: - 로고 이미지 뷰
private struct LogoImageView: View {
    fileprivate var body: some View {
        HStack {
            Spacer(minLength: 30)
            Image("LoginLogo")
                .resizable()
                .frame(width: 260, height: 130)
            Spacer(minLength: 30)
        }
    }
}

// MARK: - 로그인 입력창 뷰
struct LoginButtonView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @Binding var isPresentedLoginView: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            TextField("아이디 주소를 입력해 주세요.", text: $loginViewModel.username)
                .font(.system(size: 18))
                .frame(height: 22)
                .padding()
                .foregroundColor(Color.customSignTfTk)
                .background(Color(Color.customSignTfBg))
                .cornerRadius(5.0)
                .padding(.horizontal, 7)
            
            SecureField("비밀번호를 입력해주세요.", text: $loginViewModel.password)
                .font(.system(size: 18))
                .frame(height: 22)
                .padding()
                .foregroundColor(Color.customSignTfTk)
                .background(Color.customSignTfBg)
                .cornerRadius(5.0)
                .padding(.horizontal, 7)
            
            Button(action: {
                loginViewModel.login()
                isPresentedLoginView.toggle()
            }) {
                Text("로그인")
                    .font(.system(size: 18, weight: .bold))
                    .frame(height: 22)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.customBlue)
                    .cornerRadius(5.0)
                    .padding(.horizontal, 7)
            }
            .alert(isPresented: $loginViewModel.showAlert) {
                Alert(title: Text("알림"), message: Text(loginViewModel.alertMessage), dismissButton: .default(Text("확인")))
            }
        }
        .padding()
    }
}

// MARK: - 소셜 로그인 뷰
private struct SocialLoginButtonView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    fileprivate var body: some View {
        VStack(spacing: 10) {
            HStack {
                Rectangle()
                    .frame(width: 50, height: 1)
                    .foregroundColor(.gray)
                Text("다른 방법으로 로그인 하기")
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
                Rectangle()
                    .frame(width: 50, height: 1)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 5)
            
            Button(action: {
                authViewModel.send(action: .googleLogin)
                print("소셜 로그인 버튼 클릭됨")
            }) {
                Image("google")
                    .font(.system(size: 40))
                    .clipShape(Circle())
            }
        }
        .padding()
    }
}

// MARK: - 회원가입 아이디 비밀번호 찾기 뷰
private struct SignUpFindView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    fileprivate var body: some View {
        HStack(spacing: 5) {

            NavigationLink(destination: SignUpView()) {
                Text("회원가입")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
            }
            Text(" | ")
                .foregroundColor(.gray)
                .font(.system(size: 16))

            NavigationLink(destination: FindIdView()) {
                Text("아이디 찾기")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
            }
            Text(" | ")
                .foregroundColor(.gray)
                .font(.system(size: 16))
            
            NavigationLink(destination: FindPwView()) {
                Text("비밀번호 찾기")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
            }
        }
        .padding()
    }
}

#Preview {
    LoginView()
        .environmentObject(PathModel())
}

//struct LoginView: View {
//    @EnvironmentObject var pathModel: PathModel
//    @State private var isPresentedLoginView: Bool = false
//    @EnvironmentObject var authViewModel: AuthenticationViewModel
//    
//    var body: some View {
//        NavigationStack(path: $pathModel.paths) {
//            LoginContentView(
//                loginViewModel: LoginViewModel(),
//                isPresentedLoginView: $isPresentedLoginView
//            )
//            .navigationDestination(
//                for: PathType.self,
//                destination: { PathType in
//                    switch PathType {
//                    case .signUpView:
//                        SignUpView()
//                            .navigationBarBackButtonHidden()
//                    case .findIdView:
//                        FindIdView()
//                            .navigationBarBackButtonHidden()
//                    case .findPwView:
//                        FindPwView()
//                            .navigationBarBackButtonHidden()
//                    }
//                }
//            )
//            .navigationDestination(isPresented: $isPresentedLoginView) {
//                OnboardingFlowView()
//            }
//        }
//        .environmentObject(pathModel)
//
//    }
//}
//// MARK: -
//private struct LoginContentView: View {
//    @ObservedObject private var loginViewModel: LoginViewModel
//    @Binding private var isPresentedLoginView: Bool
//    @EnvironmentObject var authViewModel: AuthenticationViewModel
//    
//    init(loginViewModel: LoginViewModel, isPresentedLoginView: Binding<Bool>) {
//        self.loginViewModel = loginViewModel
//        self._isPresentedLoginView = isPresentedLoginView
//    }
//    
//    var body: some View {
//        VStack(spacing: 10) {
////            CustomNavigationBar()
//            Spacer().frame(height: 100)
//            
//            LogoImageView()
//            LoginButtonView(
//                loginviewModel: loginViewModel,
//                isPresentedLoginView: $isPresentedLoginView
//            )
//            SocialLoginButtonView()
//            SignUpFindView()
//            Spacer()
//        }
//        .padding(.top, 20)
//        .edgesIgnoringSafeArea(.top)
//        .background(Color.customBackground)
//    }
//}
//
//// MARK: - 로고 이미지 뷰
//private struct LogoImageView: View {
//    fileprivate var body: some View {
//        HStack {
//            Spacer(minLength: 30)
//            Image("LoginLogo")
//                .resizable()
//                .frame(width: 260, height: 130)
//            Spacer(minLength: 30)
//        }
//    }
//}
//// MARK: - 로그인 입력창 뷰
//struct LoginButtonView: View {
//    @ObservedObject var loginviewModel: LoginViewModel
//    @Binding var isPresentedLoginView: Bool
//    
//    var body: some View {
//        VStack(spacing: 10) { // Reduced spacing
//            TextField("아이디 주소를 입력해 주세요.", text: $loginviewModel.username)
//                .font(.system(size: 18))
//                .frame(height: 22)
//                .padding()
//                .foregroundColor(Color.customSignTfTk)
//                .background(Color(Color.customSignTfBg))
//                .cornerRadius(5.0)
//                .padding(.horizontal, 7)
//            
//            SecureField("비밀번호를 입력해주세요.", text: $loginviewModel.password)
//                .font(.system(size: 18))
//                .frame(height: 22)
//                .padding()
//                .foregroundColor(Color.customSignTfTk)
//                .background(Color.customSignTfBg)
//                .cornerRadius(5.0)
//                .padding(.horizontal, 7)
//            
//            Button(action: {
//                isPresentedLoginView.toggle()
//            }) {
//                Text("로그인")
//                    .font(.system(size: 18, weight: .bold))
//                    .frame(height: 22)
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.customBlue)
//                    .cornerRadius(5.0)
//                    .padding(.horizontal, 7)
//            }
//        }
//        .padding()
//    }
//}
//// MARK: - 소셜 로그인 뷰
//private struct SocialLoginButtonView: View {
//    
//    @EnvironmentObject var authViewModel: AuthenticationViewModel
//    
//    fileprivate var body: some View {
//        VStack(spacing: 10) {
//            HStack {
//                Rectangle()
//                    .frame(width: 50, height: 1)
//                    .foregroundColor(.gray)
//                Text("다른 방법으로 로그인 하기")
//                    .foregroundColor(.gray)
//                    .font(.system(size: 15))
//                Rectangle()
//                    .frame(width: 50, height: 1)
//                    .foregroundColor(.gray)
//            }
//            .padding(.bottom, 5)
//            
//            Button(action: {
//                authViewModel.send(action: .googleLogin)
//                print("소셜 로그인 버튼 클릭됨")
//            }) {
//                Image( "google")
//                    .font(.system(size: 40))
//                    .clipShape(Circle())
//            }
//        }
//        .padding()
//    }
//}
//// MARK: - 회원가입 아이디 비밀번호 찾기 뷰
//private struct SignUpFindView: View {
//    @EnvironmentObject private var pathModel: PathModel
//    
//    fileprivate var body: some View {
//        HStack(spacing: 5) {
//            Button(action: {
//                pathModel.paths.append(.signUpView)
//            }) {
//                Text("회원가입")
//                    .foregroundColor(.gray)
//                    .font(.system(size: 16))
//            }
//            Text(" | ")
//                .foregroundColor(.gray)
//                .font(.system(size: 16))
//            
//            Button(action: {
//                pathModel.paths.append(.findIdView)
//            }) {
//                Text("아이디 찾기")
//                    .foregroundColor(.gray)
//                    .font(.system(size: 16))
//            }
//            Text(" | ")
//                .foregroundColor(.gray)
//                .font(.system(size: 16))
//            
//            Button(action: {
//                pathModel.paths.append(.findPwView)
//            }) {
//                Text("비밀번호 찾기")
//                    .foregroundColor(.gray)
//                    .font(.system(size: 16))
//            }
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    LoginView()
//        .environmentObject(PathModel())
//}
