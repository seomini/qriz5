//
//  StudyDailyView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/06/13.
//

import SwiftUI

struct StudyDailyView: View {
    var body: some View {
        VStack {
            CustomNavigationBar(
                isDisplayLeftBtn: false,
                isDisplayRightBtn: false,
                isCenterTitle: true,
                centerTitleType: .dailystudy
            )
            Spacer().frame(height: 20)
            DailyconceptView()
            DailyButtonView()
            DailyTestView()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}

// MARK: 관련된 개념 뷰
struct DailyconceptView: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Spacer()
            
            Text("관련된 개념")
                .font(.system(size: 19,weight: .bold))
            Spacer()
            
            Divider()
            
            Spacer()
            
            Text("1. 데이터 베이스")
                .font(.system(size: 18,weight: .bold))
            TextEditor(text: .constant("지금 쓰고 있는 것들에 대해서"))
                .font(.system(size: 17))
                .foregroundColor(Color.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

// MARK: 관련된 버튼 뷰
struct DailyButtonView: View {
    var body: some View {
        VStack{
            Spacer().frame(height: 30)
            
            HStack {
                Button(action: {
                    // Button action here
                }) {
                    VStack {
                        Spacer()
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
                }

                Button(action: {
                    // Button action here
                }) {
                    VStack {
                        Spacer()
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
            }
            
            Spacer().frame(height: 30)
            
            Button(action: {

            }) {
                Text("개념서 보러가기")
                    .font(.system(size: 18, weight: .bold))
                    .frame(height: 22)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .padding(.horizontal, 7)
            }
        }
    }
}

// MARK: 관련된 테스트 뷰
struct DailyTestView: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                
                Text("관련된 테스트")
                    .font(.system(size: 19,weight: .bold))
                
                Spacer()
                
                Button(action: {
                    // Button action here
                }) {
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
                            Rectangle()
                                .fill(Color.gray)
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
}

#Preview {
    StudyDailyView()
}

