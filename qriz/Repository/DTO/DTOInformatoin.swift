//
//  DTOInformatoin.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/07/16.
//

import Foundation

// MARK: - UserDTO
struct UserDTO: Codable {
    var userId: String                  // 사용자 구분 키
    var username: String               // 아이디
    var password: String               // 비밀번호 또는 소셜 엑세스 토큰
    var email: String                  // 이메일
    var role: String                   // 권한 정보 (예: "Customer", "Admin")
    var provider: String               // 소셜 로그인 provider (예: Google, Kakao)
    var providerId: String             // 소셜 로그인 provider_id (예: Google_121313313)
    var createdAt: String              // 가입 시간 (ISO8601 문자열)
    var updatedAt: String              // 수정 시간 (ISO8601 문자열)
}

// MARK: - QuestionDTO
struct QuestionDTO: Codable {
    var questionId: Int64              // 문제 구분 키
    var skillId: Int64                 // 문제 유형 외래 키
    var category: Int                  // 문제 유형 (1: preview / 2: Daily / 3: exam)
    var question: String               // 문항
    var option1: String                // 선택지 1
    var option2: String                // 선택지 2
    var option3: String                // 선택지 3
    var option4: String                // 선택지 4
    var answer: String                 // 정답 (선택지 1/선택지 2/선택지 3/선택지 4)
    var solution: String               // 해설
    var difficulty: Int                // 난이도
    var timeLimit: Int                 // 제한 시간
}

// MARK: - TestCategoryDTO
struct TestCategoryDTO: Codable {
    var categoryId: Int                // 문제 유형 구분 키
    var category: String               // 문제 유형 이름
}

// MARK: - UserActivityDTO
struct UserActivityDTO: Codable {
    var activityId: Int64              // 기록 구분 키
    var userId: Int64                  // 사용자 외래 키
    var questionId: Int64              // 문제 외래 키
    var testInfo: String               // 테스트 정보 (Day1, Day2 등)
    var questionNum: Int               // 문제 번호
    var checked: String                // 사용자가 체크한 정답
    var timeSpent: Int                 // 소요 시간
    var correction: Bool               // 정답 여부 (false: 오답, true: 정답)
    var date: String                  // 푼 날짜 (ISO8601 문자열)
}

// MARK: - UserDailyDTO
struct UserDailyDTO: Codable {
    var dailyId: Int64                 // 구분 키
    var userId: Int64                  // 사용자 외래 키
    var dayNumber: String              // 데일리 정보 (Day1, Day2 등)
    var completed: Bool                // 완료 여부
    var completionDate: String        // 완료 날짜 (ISO8601 문자열)
}

// MARK: - UserExamSessionDTO
struct UserExamSessionDTO: Codable {
    var examId: Int64                  // 구분 키
    var userId: Int64                  // 사용자 외래 키
    var session: String                // 모의고사 회차 (예: 1회차, 2회차 등)
    var completed: Bool                // 완료 여부
    var completionDate: String        // 완료 날짜 (ISO8601 문자열)
}

// MARK: - UserPreviewTestDTO
struct UserPreviewTestDTO: Codable {
    var previewId: Int64               // 구분 키
    var userId: Int64                  // 사용자 외래 키
    var skillId: Int64                 // 개념 외래 키
    var completed: Bool                // 완료 여부
    var completionDate: String        // 완료 날짜 (ISO8601 문자열)
}

// MARK: - SkillDTO
struct SkillDTO: Codable {
    var skillId: Int64                 // 문제 유형 구분 키
    var title: String                  // 제목 (예: 1과목 / 2과목)
    var type: String                   // 주요 항목
    var keyConcepts: String            // 세부 항목
    var frequency: Int                 // 출제 빈도
}

// MARK: - SkillLevelDTO
struct SkillLevelDTO: Codable {
    var skillLevelId: Int64            // 실력 구분 키
    var userId: Int64                  // 사용자 외래 키
    var skillId: Int64                 // 스킬 외래 키
    var difficulty: Int                // 난이도
    var currentAccuracy: Float         // 사용자 현재 이해도
    var predictAccuracy: Float         // 사용자의 다음 예측값
    var lastUpdated: String           // 갱신 시간 (ISO8601 문자열)
}

// MARK: - SurveyDTO
struct SurveyDTO: Codable {
    var surveyId: Int64                // 구분 키
    var userId: Int64                  // 사용자 외래 키
    var skillId: Int64                 // 개념 외래 키
    var checked: Bool                 // 체크 여부
}

// MARK: - NoticeDTO
struct NoticeDTO: Codable {
    var noticeId: Int64                // 공지사항 구분 키
    var userId: Int64                  // 사용자 외래 키
    var title: String                  // 제목
    var content: String                // 내용
    var date: String                  // 작성일 (ISO8601 문자열)
}

// MARK: - ApplicationDTO
struct ApplicationDTO: Codable {
    var applyId: Int64                 // 시험 접수 정보 구분 키
    var startDate: String             // 시험 점수 시작 날짜 (ISO8601 문자열)
    var endDate: String               // 시험 접수 종료 날짜 (ISO8601 문자열)
    var examDate: String              // 시험 날짜
    var testTime: String              // 시험 시간
}

// MARK: - UserApplyDTO
struct UserApplyDTO: Codable {
    var userApplyId: Int64             // 사용자 시험 접수 정보 구분 키
    var applyId: Int64                 // 시험 접수 정보 외래 키
    var userId: Int64                  // 사용자 외래 키
    var date: String                  // 시험 접수한 날짜 (ISO8601 문자열)
}

// MARK: - ClippedDTO
struct ClippedDTO: Codable {
    var clippedId: Int64              // 오답 노트 구분 키
    var activityId: Int64             // 사용자 문제 풀이 정보 외래 키
    var date: String                  // 클립한 날짜 (ISO8601 문자열)
}

// MARK: - ConceptDTO
struct ConceptDTO: Codable {
    var conceptId: Int64              // 개념서 구분 키
    var skillId: Int64               // 항목 외래 키
    var conceptContent: String        // 개념 내용
    var content: String              // 내용 (이미지 또는 텍스트로 조정 필요)
}

// MARK: - VersionDTO
struct VersionDTO: Codable {
    var versionId: Int64              // 버전 구분 키
    var versionInfo: Float            // 버전 정보
    var updateInfo: String            // 업데이트 내용
    var date: String                  // 버전 출시 날짜 (ISO8601 문자열)
}
