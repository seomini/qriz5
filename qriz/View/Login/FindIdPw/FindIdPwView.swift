//
//  FindIdPwView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/23.
//

import SwiftUI


struct FindIdPwView: View {
    @StateObject private var findIdPwViewModel = FindIdPwViewModel()
    @EnvironmentObject var pathModel: PathModel
    @State private var selectedSegment = 0
    let segments = ["아이디 찾기", "비밀번호 찾기"]

    var body: some View {
        NavigationStack {
            VStack {
                CustomNavigationBar(
                    leftBtnAction: {
                        pathModel.paths.removeLast()
                    }
                )
                
                UnderlineSegmentedControl(selectedSegment: $selectedSegment, segments: segments)
                    .padding()
                
                Spacer()
                
                if selectedSegment == 0 {
                    FindIdView_sub(findIdPwViewModel: FindIdPwViewModel())
                } else {
                    FindPwView_sub(findIdPwViewModel: FindIdPwViewModel())
                }
                
                Spacer()
                
                FindButtonView(findIdPwViewModel: findIdPwViewModel, selectedSegment: $selectedSegment)
            }
        }
    }
}


// MARK: - 아이디 찾기 뷰
struct FindIdView_sub: View {
    @ObservedObject var findIdPwViewModel: FindIdPwViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("이름")
                .font(.system(size: 18))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            
            TextField("이름을 입력해 주세요.", text: $findIdPwViewModel.name)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5.0)
            
            Spacer().frame(height: 15)
            
            Text("이메일")
                .font(.system(size: 18))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            
            HStack {
                TextField("이메일을 입력해 주세요.", text: $findIdPwViewModel.email)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5.0)
                
                Button(action: {
                    // 이메일 인증 버튼 클릭 시 수행할 작업
                    print("이메일 인증 버튼 클릭됨")
                }) {
                    Text("인증")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .frame(width: 100, height: 50)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(5.0)
                }
            }

            TextField("인증 코드를 입력해 주세요.", text: $findIdPwViewModel.verificationCode)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5.0)
        }
    }
}

// MARK: - 비밀번호 찾기 뷰
struct FindPwView_sub: View {
    @ObservedObject var findIdPwViewModel: FindIdPwViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("아이디")
                .font(.system(size: 18))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            
            TextField("아이디를 입력해 주세요.", text: $findIdPwViewModel.id)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5.0)
            
            Spacer().frame(height: 15)
            
            Text("이메일")
                .font(.system(size: 18))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            
            HStack {
                TextField("이메일을 입력해 주세요.", text: $findIdPwViewModel.email)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5.0)
                
                Button(action: {
                    // 이메일 인증 버튼 클릭 시 수행할 작업
                    print("이메일 인증 버튼 클릭됨")
                }) {
                    Text("인증")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .frame(width: 100, height: 50)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(5.0)
                }
            }

            // 인증 코드 입력 필드
            TextField("인증 코드를 입력해 주세요.", text: $findIdPwViewModel.verificationCode)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5.0)
        }
    }
}

// MARK: - 찾기 버튼 뷰
struct FindButtonView: View {
    @ObservedObject var findIdPwViewModel: FindIdPwViewModel
    @Binding var selectedSegment: Int
    
    var body: some View {
        
        Spacer()
        
        Button(action: {
            print("찾기 버튼 클릭됨")
        }) {
            Text(selectedSegment == 0 ? "아이디 찾기" : "비밀번호 찾기")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                .cornerRadius(5.0)
        }
        .padding(.horizontal)
        .padding(.bottom, 30)
        
    }
}

// Preview
#Preview {
    FindIdPwView()
}
