//
//  AnswerNoteView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/07/09.
//

import SwiftUI

struct AnswerNoteView: View {
    @State private var isDropdownOpen = false
    @State private var selectedRound = "회차 선택"

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color.customBackground.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0){
                    CustomNavigationBar(
                        isDisplayLeftBtn: false,
                        isDisplayRightBtn: false,
                        isCenterTitle: true,
                        centerTitleType: .reviewnote
                    )
                    ChangeAnswerNoteView()
                    Divider()
                    
                    SelectRoundButton(
                        selectedRound: $selectedRound,
                        isDropdownOpen: $isDropdownOpen
                    )
                    ZStack(alignment: .top) {
                        VStack {
                            SelectAnswerNoteView()
                            ScrollView {
                                MainAnswerNoteView()
                                    .padding(20)
                            }
                        }
                        .background(Color.white)
                        .edgesIgnoringSafeArea(.all)
                        
                        if isDropdownOpen {
                            SelectRoundDropdown(
                                selectedRound: $selectedRound,
                                isDropdownOpen: $isDropdownOpen
                            )
                            .zIndex(1)
                        }
                    }
                }


            }
        }
    }
}

//MARK: - SelectRoundButton
struct SelectRoundButton: View {
    @Binding var selectedRound: String
    @Binding var isDropdownOpen: Bool

    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isDropdownOpen.toggle()
                }
            }) {
                HStack {
                    Text(selectedRound)
                        .foregroundColor(selectedRound == "회차 선택" ? .gray : .black)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isDropdownOpen ? 180 : 0))
                        .foregroundColor(.black)
                }
                .frame(height: 50)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .background(Color.white)
                .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.top, 10)
        }
        .frame(height: 120)
    }
}

//MARK: - SelectRoundDropdown
struct SelectRoundDropdown: View {
    @Binding var selectedRound: String
    @Binding var isDropdownOpen: Bool

    let rounds = ["회차 선택", "1회차", "2회차", "3회차", "4회차", "5회차", "6회차", "7회차", "8회차", "9회차", "10회차"]

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        ForEach(rounds, id: \.self) { round in
                            Button(action: {
                                selectedRound = round
                                withAnimation {
                                    isDropdownOpen = false
                                }
                            }) {
                                Text(round)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(
                                        (self.selectedRound == round && round != "회차 선택")
                                        ? Color.blue.opacity(0.1)
                                        : Color.white
                                    )
                            }
                            .background(Color.white)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxHeight: 220)
            }
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
            .padding(.horizontal,17)
            .onTapGesture {
                withAnimation {
                    isDropdownOpen = false
                }
            }
        }
    }
}

//MARK: - Change
struct ChangeAnswerNoteView: View {
    @State private var selectedTab = "데일리"
    
    var body: some View {
        VStack {
            HStack {
                TabButton(title: "데일리", selectedTab: $selectedTab)
                Spacer()
                TabButton(title: "리뷰", selectedTab: $selectedTab)
                Spacer()
                TabButton(title: "모의고사", selectedTab: $selectedTab)
            }
            .padding(.horizontal)
        }
    }
}

//MARK: - Select
struct SelectAnswerNoteView: View {
    @State private var sortOption = "최신순"
    @State private var selectedFilters: Set<String> = []
    
    let filters = ["전체", "데이터 모델의 이해", "데이터 모델과 성능", "SQL 기본"]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(filters, id: \.self) { filter in
                        let isSelectedBinding = Binding(
                            get: { selectedFilters.contains(filter) },
                            set: { isSelected in
                                if filter == "전체" {
                                    selectedFilters = isSelected ? ["전체"] : []
                                } else {
                                    if isSelected {
                                        selectedFilters.insert(filter)
                                        selectedFilters.remove("전체")
                                    } else {
                                        selectedFilters.remove(filter)
                                    }
                                }
                            }
                        )
                        FilterButton(
                            title: filter,
                            imageName: filter == "전체" ? "entire" : nil,
                            isSelected: isSelectedBinding
                        )
                    }
                }
                .frame(height: 50)
                .padding(.horizontal)

            }
            Divider()
            HStack {
                Button(action: {
                    sortOption = "최신순"
                }) {
                    Text("최신순")
                        .foregroundColor(sortOption == "최신순" ? .black : .gray)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                Button(action: {
                    sortOption = "오답순"
                }) {
                    Text("오답순")
                        .foregroundColor(sortOption == "오답순" ? .black : .gray)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

//MARK: - Main
struct MainAnswerNoteView : View {
    let sampleProblems = [
        Problem(date: "문제1", fingerprint: "아래 테이블 T<S<R이 각각 다음과 같이 선언되었다. 다음 중 DELETE FROM T;를 수행한 후에 테이블 R에 남아있는 데이터로 가장 적절한 것은?", result: 0, item: ["엔티티", "식별자"]),
        Problem(date: "문제2", fingerprint: "아래 테이블 T<S<R이 각각 다음과 같이 선언되었다. 다음 중 DELETE FROM T;를 수행한 후에 테이블 R에 남아있는 데이터로 가장 적절한 것은?", result: 1, item: ["엔티티", "식별자"]),
        Problem(date: "문제3", fingerprint: "아래 테이블 T<S<R이 각각 다음과 같이 선언되었다. 다음 중 DELETE FROM T;를 수행한 후에 테이블 R에 남아있는 데이터로 가장 적절한 것은?", result: 1, item: ["엔티티", "식별자"]),
        Problem(date: "문제4", fingerprint: "아래 테이블 T<S<R이 각각 다음과 같이 선언되었다. 다음 중 DELETE FROM T;를 수행한 후에 테이블 R에 남아있는 데이터로 가장 적절한 것은?", result: 1, item: ["엔티티", "식별자"]),
        Problem(date: "문제5", fingerprint: "아래 테이블 T<S<R이 각각 다음과 같이 선언되었다. 다음 중 DELETE FROM T;를 수행한 후에 테이블 R에 남아있는 데이터로 가장 적절한 것은?", result: 1, item: ["엔티티", "식별자"])
    ]
    
    var body: some View {
        ScrollView {
            Spacer().frame(height: 10)
            VStack {
                ForEach(sampleProblems) { problem in
                    NavigationLink(destination: ResultDetailView(problem: problem)) {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(problem.date)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                Text(problem.result == 0 ? "오답" : "정답")
                                    .foregroundColor(problem.result == 0 ? .red : .green)
                                    .font(.headline)
                            }
                            Spacer()
                            Text(problem.fingerprint)
                                .font(.system(size: 14))
                                .lineLimit(2)
                                .foregroundColor(.black)
                            Spacer()
                            VStack(alignment: .leading) {
                                HStack {
                                    ForEach(problem.item, id: \.self) { item in
                                        Text(item)
                                            .padding(5)
                                            .font(.system(size: 14))
                                            .background(Color(UIColor.secondarySystemBackground))
                                            .cornerRadius(8)
                                            .shadow(radius: 1)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
                        .padding(.horizontal,1)
                    }
                    Spacer().frame(height: 20)
                }
            }
            .background(Color.white)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .frame(height: 490)
    }
}

#Preview {
    AnswerNoteView()
}
