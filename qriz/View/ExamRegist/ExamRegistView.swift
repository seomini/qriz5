//
//  ExamRegistView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/06/06.
//

import SwiftUI

struct ExamRegistView: View {
    @EnvironmentObject private var mypathModel: MyPagePathModel
    
    var body: some View {
        VStack() {
            Spacer().frame(height: 30)
            RegistTitleView()
            RegistInPutView()
            Spacer()
        }
    }
}

// MARK: - RegistTitleView
struct RegistTitleView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("시험 등록")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .lineSpacing(10)
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

// MARK: - RegistInPutView
struct RegistInPutView: View {
    @State private var selectedExamID: UUID?

    // Mock data
    let exams = [
        Exam(title: "제 52회 SQL 개발자", registrationPeriod: "01.29(월) 10:00 ~ 02.02(금) 18:00", examDate: "3월9일(토)", resultDate: "4월5일"),
        Exam(title: "제 53회 SQL 개발자", registrationPeriod: "02.15(목) 09:00 ~ 03.01(목) 18:00", examDate: "4월14일(토)", resultDate: "5월10일"),
        Exam(title: "제 54회 SQL 개발자", registrationPeriod: "03.10(토) 09:00 ~ 03.20(화) 18:00", examDate: "5월12일(토)", resultDate: "6월7일"),
        Exam(title: "제 55회 SQL 개발자", registrationPeriod: "04.05(목) 09:00 ~ 04.25(수) 18:00", examDate: "6월9일(토)", resultDate: "7월5일")
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false){
            ForEach(exams) { exam in
                ExamRowView(exam: exam, selectedExamID: $selectedExamID)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - ExamRowView
struct ExamRowView: View {
    var exam: Exam
    @Binding var selectedExamID: UUID?

    var body: some View {
        VStack{
            HStack{
                Spacer().frame(width: 10)
                VStack{
                    RegisterButton()
                }
                VStack(alignment: .leading, spacing: 5) {
                    Spacer().frame(height: 7)
                    
                    Text(exam.title)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.black)
                    Spacer().frame(height: 5)
                    Text("접수기간: \(exam.registrationPeriod)")
                        .font(.system(size: 13))
                        .foregroundColor(.black)
                    Text("시험일: \(exam.examDate)")
                        .font(.system(size: 13))
                        .foregroundColor(.black)
                    Text("결과 발표: \(exam.resultDate)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

// MARK: - RegisterButton
struct RegisterButton: View {
    @State private var isRegistered = false
    
    var body: some View {
        Button(action: {
            isRegistered.toggle()
        }) {
            Image(isRegistered ? "examregist_selected" : "examregist")
                .font(.system(size: 16))
                .foregroundColor(.white)
                .padding(8)
                .background(Color.white)
                .cornerRadius(5)
        }
    }
}

// Mock Data Model
struct Exam: Identifiable {
    let id = UUID()
    let title: String
    let registrationPeriod: String
    let examDate: String
    let resultDate: String
}

#Preview {
    ExamRegistView()
        .environmentObject(MyPagePathModel())
}
