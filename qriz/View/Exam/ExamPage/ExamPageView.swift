//
//  ExamPageView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/06/14.
//

import SwiftUI

// Mock data model
struct ExamQuestion {
    var question: String
    var fingerprint: String
    var options: [String]
}

let sampleQuestions = [
    ExamQuestion(
        question: "다음 중 SQL에서 데이터 정의어(DDL)에 해당하지 않는 것은?",
        fingerprint: "CREATE, ALTER, DROP, SELECT",
        options: ["CREATE", "ALTER", "DROP", "SELECT"]
    ),
    ExamQuestion(
        question: "다음 중 SQL의 데이터 조작어(DML)에 해당하는 것은?",
        fingerprint: "INSERT, UPDATE, DELETE, SELECT",
        options: ["INSERT", "UPDATE", "DELETE", "SELECT"]
    ),
    ExamQuestion(
        question: "다음 중 SQL의 데이터 조작어(DML)에 해당하는 것은?",
        fingerprint: "INSERT, UPDATE, DELETE, SELECT",
        options: ["INSERT", "UPDATE", "DELETE", "SELECT"]
    ),
    ExamQuestion(
        question: "다음 중 SQL의 데이터 조작어(DML)에 해당하는 것은?",
        fingerprint: "INSERT, UPDATE, DELETE, SELECT",
        options: ["INSERT", "UPDATE", "DELETE", "SELECT"]
    )
]

struct ExamPageView: View {
    @State private var currentQuestionIndex = 0
    @State private var selectedOptions: [String?] = Array(repeating: nil, count: sampleQuestions.count)
    
    var progress: Double {
        return Double(currentQuestionIndex + 1) / Double(sampleQuestions.count)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customBackground.edgesIgnoringSafeArea(.all)
                
                VStack {
                    //                CustomNavigationBar(
                    //                    isDisplayLeftBtn: true,
                    //                    isDisplayRightBtn: false,
                    //                    isCenterTitle: false,
                    //                    centerTitleType: .chpw
                    //                )
                    
                    ExamProgressBar(value: progress)
                    VStack(alignment: .leading, spacing: 20) {
                        ExamPGTitleView(
                            question: sampleQuestions[currentQuestionIndex].question,
                            questionIndex: currentQuestionIndex
                        )
                        ExamPGFingerprintView(
                            fingerprint: sampleQuestions[currentQuestionIndex].fingerprint
                        )
                        ExamPGSelectView(
                            options: sampleQuestions[currentQuestionIndex].options,
                            selectedOption: $selectedOptions[currentQuestionIndex]
                        )
                    }
                    .padding()
                    Divider()
                    VStack {
                        ExamPGButtonView(
                            currentQuestionIndex: $currentQuestionIndex,
                            totalQuestions: sampleQuestions.count,
                            selectedOptions: $selectedOptions
                        )
                    }
                }
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

// MARK: Question Title View
struct ExamPGTitleView: View {
    let question: String
    let questionIndex: Int
    
    var body: some View {
        Text(String(format: "%02d. %@", questionIndex + 1, question))
            .font(.system(size: 18))
            .padding()
    }
}

// MARK: Question Fingerprint View
struct ExamPGFingerprintView: View {
    let fingerprint: String
    
    var body: some View {
        VStack {
            Text(fingerprint)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .frame(height: 250)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 1)
    }
}

// MARK: Answer Selection View
struct ExamPGSelectView: View {
    let options: [String]
    @Binding var selectedOption: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(Array(options.enumerated()), id: \.element) { index, option in
                HStack {
                    Image(systemName: selectedOption == option ? "\(index + 1).circle.fill" : "\(index + 1).circle")
                        .foregroundColor(selectedOption == option ? .customBlue : .black) 

                    Text(option)
                        .foregroundColor(selectedOption == option ? .customBlue2 : .black)
                        .padding()
                    Spacer()
                }
                .onTapGesture {
                    selectedOption = option
                }
                .padding(.horizontal)
                .frame(height: 40)
                .background(selectedOption == option ? Color.customSelectbg_on : Color.clear)
                .background(Color.white)
                .cornerRadius(5)
            }
        }
    }
}

// MARK: Navigation Buttons View
struct ExamPGButtonView: View {
    @Binding var currentQuestionIndex: Int
    let totalQuestions: Int
    @Binding var selectedOptions: [String?]
    
    var body: some View {
        HStack {
            Button(action: {
                if currentQuestionIndex > 0 {
                    currentQuestionIndex -= 1
                }
            }) {
                Text("이전")
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            .disabled(currentQuestionIndex == 0)
            
            Spacer()
            
            Text("\(currentQuestionIndex + 1) / \(totalQuestions)")
                .padding(.horizontal, 20)
            
            Spacer()
            
            if currentQuestionIndex == totalQuestions - 1 {
                NavigationLink(destination: ResultView()) {
                    Text("결과 보기")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                Button(action: {
                    if currentQuestionIndex < totalQuestions - 1 {
                        currentQuestionIndex += 1
                    }
                }) {
                    Text("다음")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(currentQuestionIndex == totalQuestions - 1)
            }
        }
        .padding()
    }
}

// Preview
#Preview {
    ExamPageView()
}
