//
//  ConceptBookViewModel.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/07/03.
//

import Foundation
import SwiftUI

class ConceptBookViewModel: ObservableObject {
    @Published var subjects = [
        Subject(name: "데이터 모델링의 이해", topics: ["데이터모델의 이해", "엔티티", "속성", "관계", "식별자"]),
        Subject(name: "데이터 모델과 성능", topics: ["정규화", "관계와 조인의 이해", "모델이 표현하는 트랜잭션의 이해", "Null 속성의 이해", "본질식별자 vs 인조식별자"]),
        Subject(name: "SQL 기본", topics: ["관계형 데이터베이스 개요", "SELECT 문", "함수", "WHERE 절", "GROUP BY, HAVING 절", "ORDER BY 절", "조인", "표준 조인"]),
        Subject(name: "SQL 활용", topics: ["서브 쿼리", "집합 연산자", "그룹 함수", "윈도우 함수", "Top N 쿼리", "계층형 질의와 셀프 조인", "PIVOT 절과 UN PIVOT", "정규 표현식"]),
        Subject(name: "관리 구문", topics: ["DML", "TCL", "DDL", "DCL"])
    ]
}

struct Subject: Identifiable {
    let id = UUID()
    let name: String
    let topics: [String]
}
