//
//  JoinRequest.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/08/09.
//

import Foundation

struct JoinRequest: Codable {
    let username: String
    let password: String
    let nickname: String
    let email: String
}
