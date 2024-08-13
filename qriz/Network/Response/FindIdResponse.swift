//
//  FindIdResponse.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/08/07.
//

import Foundation

// MARK: - FindIdResponse
struct FindIdResponse: Codable {
    var code: Int
    var msg: String
    var data: FindIdData
}

// MARK: - FindIdData
struct FindIdData: Codable {
    var username: String
    var date: Date
}

