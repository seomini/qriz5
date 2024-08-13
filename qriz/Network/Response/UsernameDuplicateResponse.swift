//
//  UsernameDuplicateResponse.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/08/08.
//

import Foundation

struct UsernameDuplicateResponse: Codable {
    let code: Int
    let msg: String
    let data: UsernameDuplicateData
}

struct UsernameDuplicateData: Codable {
    let available: Bool
}
