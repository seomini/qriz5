//
//  ResultViewModel.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/06/19.
//

import Foundation
import SwiftUI

class ResultViewModel: ObservableObject {
    @Published var selectedSubjectIndex = 0
    let subjects = ["제 1과목", "제 2과목"]
    let subjectScores: [(subjectIndex: Int, subject: String, score: Int)] = [
        (0, "SQL기본", 20),
        (0, "SQL활용", 10),
        (0, "관리구문", 60),
        (1, "네트워크기본", 25),
        (1, "네트워크활용", 15),
        (1, "보안구문", 55)
    ]
    
    let dailyScores: [(date: String, score1: Int, score2: Int)] = [
        ("월", 40, 50),
        ("화", 35, 55),
        ("수", 45, 65),
        ("목", 50, 60),
        ("금", 30, 70),
        ("토", 55, 45),
        ("일", 60, 50)
    ]
    
    // 현재 요일을 반환하는 메서드
    func getCurrentDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "E"
        
        let currentDaySymbol = dateFormatter.string(from: Date())
        
        let daySymbols = ["일", "월", "화", "수", "목", "금", "토"]
        guard let index = dateFormatter.shortWeekdaySymbols.firstIndex(of: currentDaySymbol) else {
            return "Unknown"
        }
        
        let currentDay = daySymbols[index]
        print("Current Day: \(currentDay)")
        return currentDay
    }
    
    // 요일에 따른 색상을 반환하는 메서드
    func colorForDay(_ day: String, subjectIndex: Int) -> Color {
        let currentDay = getCurrentDay()
        if subjectIndex == 0 {
            return day == currentDay ? Color("customchartDay1") : Color("customchartODay1")
        } else {
            return day == currentDay ? Color("customchartDay2") : Color("customchartODay2")
        }
    }
    
    func colorForScore(_ score: Int, maxScore: Int) -> Color {
        let normalizedScore = Double(score) / Double(maxScore)
        let brightness = 1.0 - normalizedScore
        return Color.blue.opacity(1.0 - brightness * 0.6)
    }
    
    var scoresForCurrentSubject: [(subject: String, score: Int)] {
        subjectScores
            .filter { $0.subjectIndex == selectedSubjectIndex }
            .map { ($0.subject, $0.score) }
    }
    
    var maxScore: Int {
        scoresForCurrentSubject.map { $0.score }.max() ?? 100
    }
    
    func previousSubject() {
        selectedSubjectIndex = (selectedSubjectIndex - 1 + subjects.count) % subjects.count
    }
    
    func nextSubject() {
        selectedSubjectIndex = (selectedSubjectIndex + 1) % subjects.count
    }
}
