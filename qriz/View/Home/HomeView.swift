//
//  HomeView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/27.
//
//
import SwiftUI

struct HomeView: View {
    
    @StateObject private var homeViewMoodel = HomeViewModel()
    @StateObject private var myPagePathModel = MyPagePathModel()
    
    var body: some View {
        NavigationStack { // NavigationStack을 TabView 바깥으로 이동
            ZStack {
                TabView(selection: $homeViewMoodel.selectedTab) {
                    MainPageView()
                    .tabItem {
                        VStack{
                            Image(
                                homeViewMoodel.selectedTab == .mainPage
                                ? "tab_home_on"
                                : "tab_home_off"
                            )
                            Text("홈")
                                .font(.system(size: 50, weight: .bold))
                        }
                    }
                    .tag(Tab.mainPage)
                    
                    ConceptBookView()
                    .tabItem {
                        VStack{
                            Image(
                                homeViewMoodel.selectedTab == .test
                                ? "tab_book_on"
                                : "tab_book_off"
                            )
                            Text("개념서")
                        }
                    }
                    .tag(Tab.test)
                    
                    AnswerNoteView()
                    .tabItem {
                        VStack{
                            Image(
                                homeViewMoodel.selectedTab == .conceptBook
                                ? "tab_ox_on"
                                : "tab_ox_off"
                            )
                            Text("오답노트")
                        }
                    }
                    .tag(Tab.conceptBook)
                    
                    MyPageView()
                    .tabItem {
                        VStack{
                            Image(
                                homeViewMoodel.selectedTab == .myPage
                                ? "tab_mypage_on"
                                : "tab_mypage_off"
                            )
                            Text("마이")
                        }
                    }
                    .tag(Tab.myPage)
                }
                .environmentObject(homeViewMoodel)
                .navigationBarBackButtonHidden()
                SeperatorListView()
            }
        }
    }
}
//MARK: -구분선
private struct SeperatorListView: View {
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            Rectangle()
                .fill(
                  LinearGradient(
                    gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]),
                    startPoint: .top,
                    endPoint: .bottom
                  )
                )
                .frame(height: 10)
                .padding(.bottom, 50)
        }
    }
}
#Preview {
    HomeView()

}
