import SwiftUI
import Charts

struct Problem: Identifiable {
    var id = UUID()
    var date: String
    var fingerprint: String
    var result: Int
    var item: [String]
}

struct ResultView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.customBackground
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ResultTitleView()
                        ResultChartCircleView()
                        ResultChartBarView()
                        ResultProblemView()
                        ResultButtonView()
                    }
                    .padding(20)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: ResultTitleView
struct ResultTitleView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Spacer().frame(height: 25)
                HStack(spacing: 0){
                    Text("민이")
                        .font(.system(size: 24, weight: .bold))
                    Text("님의")
                        .font(.system(size: 24, weight: .bold))
                }
                HStack(spacing: 0){
                    Text("ㅇㅇ")
                        .font(.system(size: 24, weight: .bold))
                    Text("평가 결과예요!")
                        .font(.system(size: 24, weight: .bold))
                }
                Spacer().frame(height: 20)
                Text("과목별 과목점수")
                    .font(.system(size: 22, weight: .bold))
            }
            Spacer()
        }
    }
}

// MARK: ResultChartCircleView
struct ResultChartCircleView: View {
    @StateObject private var viewModel = ResultViewModel()

    var body: some View {
        VStack {
            Spacer().frame(height: 5)
            Text(viewModel.subjects[viewModel.selectedSubjectIndex])
                .font(.system(size: 20))
            
            Chart {
                ForEach(viewModel.scoresForCurrentSubject, id: \.subject) { subjectScore in
                    let color = viewModel.colorForScore(subjectScore.score, maxScore: viewModel.maxScore)
                    SectorMark(
                        angle: .value("Score", Double(subjectScore.score)),
                        innerRadius: .ratio(0.5),
                        outerRadius: .ratio(1.0)
                    )
                    .foregroundStyle(color)
                }
            }
            .frame(width: 300, height: 200)
            .padding()
        }
        .background(Color.white)
        .cornerRadius(15)
        
        HStack {
            Spacer()
            
            Button(action: {
                viewModel.previousSubject()
            }) {
                Text("<")
                    .foregroundColor(.blue)
            }
            
            Text("\(viewModel.selectedSubjectIndex + 1)/\(viewModel.subjects.count)")
            
            Button(action: {
                viewModel.nextSubject()
            }) {
                Text(">")
                    .foregroundColor(.blue)
            }
        }
    }
}

// MARK: ResultChartBarView
struct ResultChartBarView: View {
    @StateObject private var viewModel = ResultViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("주간 과목점수 비교")
                .font(.system(size: 20, weight: .bold))
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                Text("월~일요일까지 통계")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                Spacer()
                Chart {
                    ForEach(viewModel.dailyScores.suffix(7), id: \.date) { dailyScore in
                        BarMark(
                            x: .value("Date", dailyScore.date),
                            y: .value("Score", dailyScore.score1)
                        )
                        .foregroundStyle(Color.customchartDay1)
                        .position(by: .value("Subject", "1과목"))

                        BarMark(
                            x: .value("Date", dailyScore.date),
                            y: .value("Score", dailyScore.score2)
                        )
                        .foregroundStyle(Color.customchartDay2)
                        .position(by: .value("Subject", "2과목"))
                    }
                }
                .frame(height: 200)
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
        }
    }
}

// MARK: ResultProblemView
struct ResultProblemView: View {
    let sampleProblems = [
        Problem(date: "문제1", fingerprint: "아래 테이블 T<S<R이 각각 다음과 같이 선언되었다. 다음 중 DELETE FROM T;를 수행한 후에 테이블 R에 남아있는 데이터로 가장 적절한 것은?", result: 0, item: ["엔티티", "식별자"]),
        Problem(date: "문제2", fingerprint: "아래 테이블 T<S<R이 각각 다음과 같이 선언되었다. 다음 중 DELETE FROM T;를 수행한 후에 테이블 R에 남아있는 데이터로 가장 적절한 것은?", result: 1, item: ["엔티티", "식별자"]),
        Problem(date: "문제3", fingerprint: "아래 테이블 T<S<R이 각각 다음과 같이 선언되었다. 다음 중 DELETE FROM T;를 수행한 후에 테이블 R에 남아있는 데이터로 가장 적절한 것은?", result: 1, item: ["엔티티", "식별자"]),
        Problem(date: "문제4", fingerprint: "아래 테이블 T<S<R이 각각 다음과 같이 선언되었다. 다음 중 DELETE FROM T;를 수행한 후에 테이블 R에 남아있는 데이터로 가장 적절한 것은?", result: 1, item: ["엔티티", "식별자"]),
        Problem(date: "문제5", fingerprint: "아래 테이블 T<S<R이 각각 다음과 같이 선언되었다. 다음 중 DELETE FROM T;를 수행한 후에 테이블 R에 남아있는 데이터로 가장 적절한 것은?", result: 1, item: ["엔티티", "식별자"])
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 0){
                Text("민이")
                    .font(.system(size: 24, weight: .bold))
                Text("님의")
                    .font(.system(size: 24))
            }
            Text("문제 풀이 결과")
                .font(.system(size: 24))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
                        .shadow(radius: 1)
                        .padding(.horizontal,1)
                    }
                    Spacer().frame(height: 20)
                }
            }
        }
        .frame(height: 490)
    }
}

// MARK: ResultButtonView
struct ResultButtonView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    @State private var navigateToHome = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Spacer().frame(height: 20)
            HStack(spacing: 0) {
                Text("민이")
                    .font(.system(size: 24, weight: .bold))
                Text("님이 보완하면")
                    .font(.system(size: 24))
            }
            Text("좋은 개념이에요!")
                .font(.system(size: 24))
            
            Spacer().frame(height: 24)
            
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
            
            Spacer().frame(height: 15)
        }
    }
}

#Preview {
    ResultView()
}
