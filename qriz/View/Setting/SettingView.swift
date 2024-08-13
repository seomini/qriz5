//
//  SettingView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/29.
//

import SwiftUI

import SwiftUI

struct SettingView: View {
    @StateObject private var settingViewModel = SettingViewModel()
    
    var body: some View {
        NavigationStack {
            NavigationStack {
                ZStack {
                    Color.customBackground.edgesIgnoringSafeArea(.all)
                    VStack {
        
                        profileSettingView(settingViewModel: settingViewModel)
                        settingSettingView()
                        Spacer()
                    }
                }
            }
            .navigationTitle("설정")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton()
                }
            }
        }
    }
}
struct profileSettingView : View {
    @ObservedObject var settingViewModel: SettingViewModel
    let emailText = "seomini@naver.com"
    var body: some View{
        HStack{
            Spacer().frame(width: 10)
            VStack(alignment: .leading, spacing: 20) {
                Text("서민이님")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)
                HStack{
                    Text("") +
                    Text(emailText)
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

struct settingSettingView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
                                                            
            HStack {
                Text("회원정보 수정")
                    .font(.body)
                Spacer()
                Image("Property")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            
            HStack {
                Text("프로필 수정")
                    .font(.body)
                Spacer()
                Image("Property")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            
            NavigationLink(destination: ChangePwView()) {
                HStack {
                    Text("비밀번호 변경")
                        .font(.body)
                    Spacer()
                    Image("Property")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            }
            .buttonStyle(PlainButtonStyle()) 

            
            
            HStack {
                Text("알람 설정")
                    .font(.body)
                Spacer()
                Image("Property")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            
            
            HStack {
                Text("로그아웃")
                    .font(.body)
                Spacer()
                Image("Property")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            
            
            HStack {
                Text("계정 탈퇴 버튼 클릭됨")
                    .font(.body)
                Spacer()
                Image("Property")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .padding(20)
    


    }
}



struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

