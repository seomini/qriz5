//
//  LoginRequest.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/08/07.
//

import Foundation

// MARK: - LoginRequest
struct LoginRequest: Codable {
    var username: String  // 사용자 아이디
    var password: String  // 비밀번호
}

