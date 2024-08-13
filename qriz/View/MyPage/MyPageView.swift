//
//  MyPageView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/28.
//

import SwiftUI

struct MyPageView: View {
    @EnvironmentObject private var mypathModel: MyPagePathModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.customBackground.edgesIgnoringSafeArea(.all)
                VStack {
                    MyPageViewContentView()
                }
            }
        }
    }
}

struct MyPageViewContentView : View {
    
    var body: some View {
        VStack {
            CustomNavigationBar(
                isDisplayLeftBtn: false,
                isDisplayRightBtn: false,
                isCenterTitle: true,
                centerTitleType: .mypage
            )
            
            Spacer().frame(height:30)
            
            MyPageTitleView(userName: "User Name")
            
            Spacer().frame(height:30)
            
            MyPageExamView()
            
            Spacer().frame(height:30)
            
            MyPageServiceView()
            
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - MyPageTitleView
struct MyPageTitleView: View {
    var userName: String
    
    var body: some View {
        HStack{
            Text(userName)
                .font(.system(size: 24,weight: .bold))
                .padding(.top)
            
            NavigationLink(destination: SettingView()) {
                Image("Property")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black)
                    .padding(3)
            }
            
            Spacer()
        }
        .padding(3)
    }
}

// MARK: - 상단 시험 관련 버튼 뷰
struct MyPageExamView: View {
    @EnvironmentObject private var mypathModel: MyPagePathModel
    @State var showModal = false
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        HStack {
            
            Button(action: {
                homeViewModel.changeSelectedTab(.conceptBook)
            }) {
                VStack {
                    Image("oximg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .padding(.bottom, 4)
                    Text("오답노트")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                }
                .frame(maxWidth: .infinity, maxHeight: 90)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                .padding(4)
            }
            
            
            
            Button(action: {
                self.showModal.toggle()
            }) {
                VStack {
                    Image("icon_con_Exam")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .padding(.bottom, 4)
                    Text("시험 등록")
                        .font(.system(size: 16))                        
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                }
                .frame(maxWidth: .infinity, maxHeight: 90)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                .padding(4)
                .sheet(isPresented: self.$showModal) {
                    ExamRegistView()
                        .presentationDetents([
                            .fraction(0.75)
                        ])
                }
            }
        }
        .padding(3)
    }
}

// MARK: - 고객 센터 리스트 뷰
struct MyPageServiceView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("고객센터")
                .font(.headline)
                .padding(.leading)
            Divider()

            HStack {
                Text("FAQ")
                    .font(.body)
                Spacer()
                Image("Property")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .frame(height: 45)
            .padding(.horizontal)
            
            HStack {
                Text("서비스 이용약관")
                    .font(.body)
                Spacer()
                Image("Property")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .frame(height: 45)
            .padding(.horizontal)
            
            HStack {
                Text("개인정보처리 방침")
                    .font(.body)
                Spacer()
                Image("Property")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .frame(height: 45)
            .padding(.horizontal)
            
            HStack {
                Text("버전정보")
                    .font(.body)
                Spacer()
                Image("Property")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .frame(height: 45)
            .padding(.horizontal)
            
            HStack {
                Text("공지사항")
                    .font(.body)
                Spacer()
                Image("Property")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .frame(height: 45)
            .padding(.horizontal)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}



#Preview {
    MyPageView()
}
