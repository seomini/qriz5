//
//  LoginResponse.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/08/07.
//

import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    var refreshToken: String    // Bearer 토큰
    var code: Int               // 상태 코드
    var msg: String             // 메시지
    var data: LoginData         // 로그인 데이터
    
    // MARK: - LoginData
    struct LoginData: Codable {
        var id: Int              // 사용자 ID
        var username: String     // 사용자 아이디
        var createdAt: Date      // 가입 시간
        
        // Date 포맷터
        private enum CodingKeys: String, CodingKey {
            case id, username, createdAt
        }
        
        // 커스텀 Date 포맷터
        private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            return formatter
        }()
        
        // Date 디코딩
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            username = try container.decode(String.self, forKey: .username)
            let dateString = try container.decode(String.self, forKey: .createdAt)
            guard let date = dateFormatter.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(forKey: .createdAt, in: container, debugDescription: "Date string does not match format expected by formatter.")
            }
            createdAt = date
        }
        
        // Date 인코딩
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(username, forKey: .username)
            let dateString = dateFormatter.string(from: createdAt)
            try container.encode(dateString, forKey: .createdAt)
        }
    }
}

