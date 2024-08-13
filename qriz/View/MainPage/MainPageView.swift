//
//  MainPageView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/28.
//

import SwiftUI

struct MainPageView: View {
    @StateObject private var homeViewModel = HomeViewModel()

    var body: some View {
        
        ZStack {
                Color.customBackground.edgesIgnoringSafeArea(.all)
            NavigationStack {
                ScrollView {
                    VStack {
                        ExamMainLogoView()
                        ExamScheduleView(mainPageViewModel: MainPageViewModel())
                        Spacer().frame(height: 30)
                        ReviewTestExamButtonView()
                        Spacer().frame(height: 40)
                        DailyScheduleView()
                        Spacer()
                    }
                    .background(Color.customBackground)
                }
            }
        }
    }
}

//MARK: 메인로고
struct ExamMainLogoView: View {
    var body: some View {
        VStack {
            HStack {
                Image("MainLogo")
                Spacer()
            }
            .padding()
        }
        .background(Color.customBackground)
    }
}

//MARK: 시험 일정 표기 화면
struct ExamScheduleView: View {
    @ObservedObject var mainPageViewModel: MainPageViewModel
    @State var showModal = false
    var intnumber = 2
    
    var body: some View {
        HStack {
             VStack(alignment: .leading) {
                 Spacer().frame(height:20)
                 if intnumber == 1 {
                     // if문 시험을 접수 했을경우
                     VStack(spacing: 0) {
                         Spacer().frame(height: 15)
                         
                         Text("민이 님의\n시험 일정을 등록해보세요!")
                             .font(.system(size: 22, weight: .bold))
                             .multilineTextAlignment(.leading)
                             .frame(maxWidth: .infinity, alignment: .leading)
                         Spacer().frame(height: 15)
                         
                         Divider().background(Color.black).frame(height: 10)
                         
                         Spacer().frame(height: 15)
                         
                         Text("등록된 일정이 없어요.")
                             .font(.system(size: 18, weight: .bold))
                             .multilineTextAlignment(.leading)
                             .frame(maxWidth: .infinity, alignment: .leading)
                         Spacer().frame(height: 7)
                         Text("지금바로 등록할까요?")
                             .font(.system(size: 16))
                             .multilineTextAlignment(.leading)
                             .frame(maxWidth: .infinity, alignment: .leading)
                         
                         Spacer().frame(height: 22)
                         
                         Button(action: {
                             self.showModal.toggle()
                         }) {
                             Text("등록하기")
                                 .font(.system(size: 18, weight: .bold))
                                 .frame(height: 22)
                                 .foregroundColor(.white)
                                 .frame(maxWidth: .infinity)
                                 .padding()
                                 .background(Color.customButton)
                                 .cornerRadius(10)
                                 .padding(.horizontal, 7)
                                 .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
                         }
                         .frame(maxWidth: .infinity, alignment: .center)
                         .sheet(isPresented: self.$showModal) {
                             ExamRegistView()
                         }
                         Spacer().frame(height: 20)
                     }
                     .padding()
                     .frame(maxWidth: .infinity, maxHeight: .infinity)
                     .background(Color.white)
                     .cornerRadius(15)


                 }
                 else{
                     // else 시험 접수를 안했을 경우
                     Text("민이 님이 등록한 \n시험까지")
                         .foregroundColor(.black)
                         .font(.system(size: 25, weight: .bold))
                         .lineSpacing(10)
                     
                     Spacer().frame(height:30)
                     
                     HStack(spacing: 0) {
                         Text("D")
                             .foregroundColor(.white)
                             .font(.system(size: 32, weight: .bold))
                             .padding(4)
                             .frame(width:60, height:60)
                             .background(Color.customButton)
                             .cornerRadius(10)
                             
                         
                         Text(" - ")
                             .foregroundColor(Color.customButton)
                             .font(.system(size: 32, weight: .bold))
                         
                         Text("30")
                             .foregroundColor(.white)
                             .font(.system(size: 32, weight: .bold))
                             .padding(4)
                             .frame(width:70, height: 60)
                             .background(Color.customButton)
                             .cornerRadius(10)
                     }
                     
                     Spacer().frame(height:50)
                     
                     VStack(spacing: 0) {
                         Spacer().frame(height: 15)
                         
                         Text("시험일 : 3월9일(토)")
                             .font(.system(size: 20, weight: .bold))
                             .multilineTextAlignment(.leading)
                             .frame(maxWidth: .infinity, alignment: .leading)
                         
                         Spacer().frame(height: 10)
                         
                         Text("재 52회 SQL 개발자")
                             .font(.system(size: 14, weight: .bold))
                             .multilineTextAlignment(.leading)
                             .frame(maxWidth: .infinity, alignment: .leading)
                         Spacer().frame(height: 7)
                         Text("접수기간: 01.29(월) 10:00 ~ 02:02(금) 18:00")
                             .font(.system(size: 14))
                             .multilineTextAlignment(.leading)
                             .frame(maxWidth: .infinity, alignment: .leading)
                         
                         Spacer().frame(height: 22)
                         
                         Divider().background(Color.black).frame(height: 10)
                         
                         Spacer().frame(height: 12)
                         
                         Text("일정을 변경할까요?")
                             .font(.system(size: 16))
                             .multilineTextAlignment(.leading)
                             .frame(maxWidth: .infinity, alignment: .leading)
                         
                         Spacer().frame(height: 12)
                         
                         Button(action: {
                             self.showModal.toggle()
                         }) {
                             Text("변경하기")
                                 .font(.system(size: 18, weight: .bold))
                                 .frame(height: 22)
                                 .foregroundColor(.white)
                                 .frame(maxWidth: .infinity)
                                 .padding()
                                 .background(Color.customButton)
                                 .cornerRadius(10)
                                 .padding(.horizontal, 7)
                                 .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
                         }
                         .frame(maxWidth: .infinity, alignment: .center)
                         .sheet(isPresented: self.$showModal) {
                             ExamRegistView()
                         }
                         Spacer().frame(height: 15)
                     }
                     .padding()
                     .frame(maxWidth: .infinity, maxHeight: .infinity)
                     .background(Color.white)
                     .cornerRadius(15)
                 }
             }
             .padding()
             .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
             Spacer()
        }
        .background(Color.customBackground)
    }
}

//MARK: 오늘의 공부 이동 화면
struct DailyScheduleView: View {
    @StateObject private var mainPageViewModel = MainPageViewModel()

    var body: some View {
        VStack {
            StudyButtonListView(selectedDay: $mainPageViewModel.selectedDay)
            DailyStudyView()
            DailyStudyButtonView()
            Spacer().frame(height: 50)
        }
        .background(Color.customBackground)
        .environmentObject(mainPageViewModel)
    }
}

struct StudyButtonListView: View {
    @Binding var selectedDay: Int?

    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 5)
                Text("오늘의 공부")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.leading)
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(1...10, id: \.self) { index in
                        StudyButton(title: "Day", subtitle: "\(index)", isSelected: Binding(
                            get: { selectedDay == index },
                            set: { isSelected in
                                if isSelected {
                                    selectedDay = index
                                } else if selectedDay == index {
                                    selectedDay = nil
                                }
                            }
                        ))
                        .frame(width: 78, height: 74)
                        .background(Color.red)
                        .cornerRadius(8)
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
            }
        }
    }
}

struct StudyButton: View {
    var title: String
    var subtitle: String
    @Binding var isSelected: Bool

    var body: some View {
        Button(action: {
            isSelected.toggle()
        }) {
            VStack(spacing: 4) {
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(isSelected ? Color.custommainDayTC_on : Color.custommainDayTC_off)
                    .padding(.top, 8)
                
                Text(subtitle)
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(isSelected ? Color.white : Color.white)
                    .padding(10)
                    .background(isSelected ? Color.custommainDayTC_on : Color.custommainDayTC_off)
                    .clipShape(Circle())
                    .padding(.bottom, 0)
            }
            .padding(8)
        }
        .frame(width: 78, height: 74)
        .background(isSelected ? Color.white : Color.custommainDayBC_off)
        .cornerRadius(8)
    }
}

//MARK: 오늘의 공부 뷰
struct DailyStudyView: View {
    @EnvironmentObject var mainPageViewModel: MainPageViewModel
    var body: some View {

        VStack {
            VStack(alignment: .leading) {
                Spacer().frame(height: 20)
                Text("공부해야 하는 주제는")
                    .font(.subheadline)
                    .padding(.bottom, 2)
                
                Text(mainPageViewModel.topicTitle)
                    .font(.headline)
                    .padding(.bottom, 5)
                
                Divider().background(Color.black).frame(height: 10)
                
                Text(mainPageViewModel.subTopicTitle)
                    .font(.headline)
                    .padding(.bottom, 2)
                
                HStack(alignment: .top, spacing: 4) {
                    Text("•")
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                        .padding(.top, 4)
                    
                    TextEditor(text: $mainPageViewModel.firstText)
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                        .frame(height: 130)
                        .padding(.bottom, 2)
                        .multilineTextAlignment(.leading)
                }
                .padding(.leading, 8)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 250)
            .padding(.horizontal, 16)
            .background(Color.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
    }
}
// MARK: 학습하러가기 버튼
struct DailyStudyButtonView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel

    var body: some View {
        NavigationLink(destination: TestDailyView()) {
            VStack{
                Text("학습하러 가기")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
            }
            .frame(height: 60)
            .background(Color.customButton)
            .cornerRadius(10)
            .padding(.horizontal)
        }
        
        
//        Button(action: {
//            homeViewModel.changeSelectedTab(.test) // ConceptBook 탭으로 전환
//        }) {
//            Text("학습하러 가기")
//                .font(.system(size: 18, weight: .bold))
//                .foregroundColor(.white)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .padding()
//        }
//        .frame(height: 60)
//        .background(Color.customButton)
//        .cornerRadius(10)
//        .padding(.horizontal)
    }
}

// MARK:  모의고사  버튼
struct ReviewTestExamButtonView: View {
    var body: some View {
            VStack {
                NavigationLink(destination: ExamView()) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("모의고사 응시")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer().frame(height: 10)
                            
                            Text("실전처럼 준비하기")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        
                        VStack {
                            HStack {
                                Spacer()
                                Image("Group")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                            }
                            Image("Vector")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 140, height: 20)
                        }
                        .padding()
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(height: 80)
                    .padding(.horizontal)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
                }
//                HStack(spacing: 16) {
//                    NavigationLink(destination: ExamView()) {
//                        VStack(alignment: .leading) {
//                            Text("모의고사 응시")
//                                .font(.system(size: 18, weight: .bold))
//                                .foregroundColor(.black)
//                            
//                            Spacer().frame(height: 10)
//                            
//                            Text("실전처럼 준비하기")
//                                .font(.system(size: 14))
//                                .foregroundColor(.black)
//                        }
//                        .frame(height: 106)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(8)
//                        .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
//                    }
//                    NavigationLink(destination: TestDailyView()) {
//                        VStack(alignment: .leading) {
//                            Text("테스트 모아보기")
//                                .font(.system(size: 18, weight: .bold))
//                                .foregroundColor(.black)
//                            
//                            Spacer().frame(height: 10)
//                            
//                            Text("테스트 유형 선택하기")
//                                .font(.system(size: 14))
//                                .foregroundColor(.black)
//                        }
//                        .frame(height: 106)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(8)
//                        .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
//                    }
//                }
//                .padding(.horizontal, 16)

            }
        }
}


#Preview {
    MainPageView()
}
