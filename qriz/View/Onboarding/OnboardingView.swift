//
//  OnboardingView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/27.
//


import SwiftUI

struct OnboardingFlowView: View {
    @State private var currentStep: Int = 0

    var body: some View {
        NavigationStack {
            VStack {
                if currentStep == 0 {
                    IntroView(currentStep: $currentStep)
                } else if currentStep == 1 {
                    OnboardingView(currentStep: $currentStep)
                } else if currentStep == 2 {
                    ConcludingView()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: 온보딩뷰
struct OnboardingView: View {
    @Binding var currentStep: Int
    @StateObject private var selectBoxViewModel = SelectBoxViewModel()

    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            OnboardingTitleView()
            Spacer().frame(height: 25)
            SelectBoxView(selectBoxViewModel: selectBoxViewModel)
            Spacer()
            selectedButtonView(currentStep: $currentStep, selectBoxViewModel: selectBoxViewModel)
        }
        .background(Color.customBackground)
    }
}

// MARK: -OnboardingView 타이틀 뷰
private struct OnboardingTitleView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("아는 개념을 체크해주세요!")
                    .foregroundColor(.black)
                    .font(.system(size: 25, weight: .bold))
                Spacer().frame(height: 5)
                Text("체크하신 결과를 토대로")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
                Text("추후 진행할 테스트의 레벨이 조정됩니다!")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

// MARK: -select Box 뷰
struct SelectBoxView: View {
    @ObservedObject var selectBoxViewModel: SelectBoxViewModel

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(selectBoxViewModel.chunkedItems, id: \.self) { rowItems in
                    HStack(spacing: 10) {
                        ForEach(rowItems) { item in
                            SelectableBoxView(item: item, action: {
                                selectBoxViewModel.toggleSelection(of: item)
                            })
                        }
                    }
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
                }
            }
            .padding()
        }
        .frame(height: 450)
    }
}

struct SelectableBoxView: View {
    let item: SelectableBox
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .cornerRadius(5.0)
                if item.isSelected {
                    Image("checked_on")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(8)
                } else {
                    Image("checked_off")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(8)
                }
            }
        }
    }
}

// MARK: -Button 뷰
struct selectedButtonView: View {
    @Binding var currentStep: Int
    @ObservedObject var selectBoxViewModel: SelectBoxViewModel

    var body: some View {
        Button(action: {
            print(selectBoxViewModel.selectedItems)
            selectBoxViewModel.submitSurvey()
            currentStep += 1
        }) {
            Text("선택완료")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.customBlue)
                .cornerRadius(5.0)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
        }
        .padding(.horizontal)
        .padding(.bottom, 30)
    }
}

// MARK: - Intro View
struct IntroView: View {
    @Binding var currentStep: Int

    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Spacer().frame(height: 25)
                    Text("SQLD를 어느정도\n알고 계신가요?")
                        .foregroundColor(.black)
                        .font(.system(size: 35, weight: .bold))
                    Spacer().frame(height: 10)
                    Text("선택하신 체크사항을 기반으로 \n맞춤으로 테스트를 제공해드려요!")
                        .foregroundColor(.gray)
                        .font(.system(size: 18))
                }
                Spacer()
            }
            .padding(.horizontal)
            Image("Onbording")
                .offset(x: 15)
            Spacer()
            Button(action: {
                currentStep += 1
            }) {
                Text("시작하기")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.customBlue)
                    .cornerRadius(5.0)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .background(Color.customBackground)
    }
}

// MARK: - Concluding View
struct ConcludingView: View {
    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Spacer().frame(height: 25)
                    Text("민이님\n환영합니다.")
                        .foregroundColor(.black)
                        .font(.system(size: 35, weight: .bold))
                    Spacer().frame(height: 10)
                    Text("준비되어 있는 오늘의 모의고사로\n시험을 같이 준비해봐요!")
                        .foregroundColor(.gray)
                        .font(.system(size: 18))
                }
                Spacer()
            }
            .padding(.horizontal)
            Spacer()
            Image("Onbording_2")
            
            NavigationLink(destination: HomeView()) {
                Text("홈으로 가기")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.customBlue)
                    .cornerRadius(5.0)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .background(Color.customBackground)
    }
}

#Preview {
    OnboardingFlowView()
}
