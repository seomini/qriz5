//
//  ResultDetailView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/06/20.
//

import SwiftUI

struct ResultDetailView: View {
    var problem: Problem
    
    var body: some View {
        ZStack {
            Color.customBackground
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                ProblmeInfoView()
                ProblmeGibonView()
                ProblmeSolutionView(items: ["엔티티", "식별자"])
                ProblmeButtonView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
        }

    }
}
//MARK: 문제 기본정보 뷰
struct ProblmeInfoView: View {
    let sampleProblems = [
        (date: "2023년도 모의고사", gwamocknumber: "1", problmenumber: "5", result: 0, item: ["엔티티", "식별자"])
    ]
    var body: some View {
        
        let problem = sampleProblems[0]
        Spacer().frame(height: 10)
        VStack{
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(problem.date)
                        .font(.headline)
                    Spacer()
                    Text(problem.result == 0 ? "오답" : "정답")
                        .foregroundColor(problem.result == 0 ? .red : .green)
                        .font(.headline)
                }
                Spacer().frame(height: 1)
                HStack{
                    Text("\(problem.gwamocknumber)과목")
                        .font(.system(size: 14))
                    Text(" | ")
                        .font(.system(size: 14))
                    Text("\(problem.problmenumber)번")
                        .font(.system(size: 14))
                }
                Spacer().frame(height: 1)
                VStack(alignment: .leading) {
                    HStack{
                        ForEach(problem.item, id: \.self) { item in
                            Text(item)
                                .padding(5)
                                .font(.system(size: 14))
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .padding()
            .frame(height:120)
            .background(Color.white)
        }
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
        .padding(20)
    }
}
//MARK: 문제 기본뷰
struct teste {
    var number : String
    var question: String
    var fingerprint: String
    var options: [String]
}

let sampleQuestion = teste(
    number : "05",
    question: "다음 중 SQL에서 데이터 정의어(DDL)에 해당하지 않는 것은?",
    fingerprint: "CREATE, ALTER, DROP, SELECT",
    options: ["CREATE", "ALTER", "DROP", "SELECT"]
)

// MARK: 문제 기본뷰
struct ProblmeGibonView: View {
    @State private var selectedOption: String? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("문제")
                .font(.system(size: 20, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                        
            HStack {
                Text("\(sampleQuestion.number). \(sampleQuestion.question)")
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            VStack {
                Text(sampleQuestion.fingerprint)
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 180)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 180)
            .padding(20)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(sampleQuestion.options.indices, id: \.self) { index in
                    HStack {
                        Image(systemName: selectedOption == sampleQuestion.options[index] ? "\(index + 1).circle.fill" : "\(index + 1).circle")
                            .resizable()
                            .frame(width:30, height: 30)
                        Text(sampleQuestion.options[index])
                            .font(.system(size: 14))
                            .padding(5)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(selectedOption == sampleQuestion.options[index] ? Color.blue.opacity(0.2) : Color.clear)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
                }
            }
        }
        .padding(20)
        VStack{
            VStack(spacing: 20) {
                Text("정답 : 번")
                    .font(.system(size: 20, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                
                Text("내가 고른답 : 번")
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(height:80)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
            
        }
        .padding(20)
    }
}


//MARK: 문제 풀이뷰
struct ProblmeSolutionView: View {
    let items: [String]
    
    var body: some View {
        VStack(spacing: 20) {
            VStack{
                Text("풀이")
                    .font(.system(size: 20,weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack{
                    Text("내용에 대한 주제")
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
            }
            
            Spacer()
            
            VStack{
                Text("활용된 개념")
                    .font(.system(size: 20,weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    ForEach(items, id: \.self) { item in
                        Button(action: {
                            // Handle button action here
                        }) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item)
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.black)
                                    Text("1과목")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 5, y: 5)
                        }
                    }
                }
                .padding(.vertical)
            }
        }
        .padding(20)
    }
}

//MARK: 학습하러가기 버튼
struct ProblmeButtonView: View {
    var body: some View {
        VStack{
            Button {
                
            } label: {
                Text("학습하러가기")
                    .font(.system(size: 16))
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.customButton)
                    .cornerRadius(5.0)
            }
        }
        .padding()
    }
}
#Preview {
    ResultDetailView(problem: Problem(date: "문제1", fingerprint: "아래 테이블 T<S<R이 각각 다음과 같이 선언되었다. 다음 중 DELETE FROM T;를 수행한 후에 테이블 R에 남아있는 데이터로 가장 적절한 것은?", result: 0, item: ["엔티티", "식별자"]))
}
