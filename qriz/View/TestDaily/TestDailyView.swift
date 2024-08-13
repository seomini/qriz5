//
//  TestDailyView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/06/13.
//

import SwiftUI

struct TestDailyView: View {
    var body: some View {
        ZStack {
            Color.customBackground.edgesIgnoringSafeArea(.all)
            NavigationStack {
                ScrollView {
                    VStack {
                        TestDailyTitle()
                        TestDailyButtonView()
                        Spacer().frame(height: 10)
                        TestDailyTestView()
                        Spacer().frame(height: 150)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                }
            }
                .navigationTitle("오늘의 공부")
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        BackButton()
                    }
                }
            
        }
    }
}
//MARK: titleView
struct TestDailyTitle: View {
    var body: some View{
        VStack(alignment: .leading, spacing: 10) {
            Spacer().frame(height: 7)
            Text("관련된 개념 보러가기")
                .font(.system(size: 20, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        
    }
}
// MARK: 관련된 버튼 뷰
struct TestDailyButtonView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    @State private var navigateToHome = false
    
    var body: some View {
        VStack{
            Spacer().frame(height: 30)
            
            HStack(spacing: 16) {
                VStack {
                    Spacer()
                    HStack {
                        Spacer().frame(width: 20)
                        Image("book")
                        Spacer()
                    }
                    HStack {
                        Text("DDL")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .padding([.bottom, .leading], 20)
                        Spacer()
                    }
                }
                .frame(height: 130)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)

                VStack {
                    Spacer()
                    HStack {
                        Spacer().frame(width: 20)
                        Image("book")
                        Spacer()
                    }
                    HStack {
                        Text("조인")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .padding([.bottom, .leading], 20)
                        Spacer()
                    }
                }
                .frame(height: 130)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
            }
            
            Spacer().frame(height: 30)
            
            NavigationLink(
                destination: HomeView()
                    .environmentObject(homeViewModel)
                    .onAppear {
                        homeViewModel.changeSelectedTab(.conceptBook)
                    },
                isActive: $navigateToHome
            ) {
                Button(action: {
                    navigateToHome = true
                }) {
                    Text("개념서 보러가기")
                        .font(.system(size: 18, weight: .bold))
                        .frame(height: 22)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
    }
}
// MARK: 관련된 테스트 뷰
struct TestDailyTestView: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                
                Text("관련된 테스트")
                    .font(.system(size: 19,weight: .bold))
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("학습전")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.gray)
                    HStack {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("프리뷰 테스트")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundColor(.black)
                            
                            ProgressView(value: 1.0)
                                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        }
                        Image("Property")
                            .frame(width: 35, height: 35)
                            .cornerRadius(5.0)
                    }
                        Text("총 점수: 점")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.gray)
                    Spacer().frame(height: 1)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("학습전")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.gray)
                    HStack {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("데일리 테스트")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundColor(.black)
                            
                            ProgressView(value: 1.0)
                                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        }
                        Image("Property")
                            .frame(width: 35, height: 35)
                            .cornerRadius(5.0)
                    }
                        Text("총 점수: 점")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.gray)
                    Spacer().frame(height: 1)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("학습전")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.gray)
                    HStack {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("모의고사 테스트")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundColor(.black)
                            
                            ProgressView(value: 1.0)
                                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        }
                        Image("Property")
                            .frame(width: 35, height: 35)
                            .cornerRadius(5.0)
                    }
                        Text("총 점수: 점")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.gray)
                    Spacer().frame(height: 1)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
            }
        }
    }
}

#Preview {
    TestDailyView()
}
