//
//  JoinResponse.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/08/09.
//

import Foundation

struct JoinResponse: Codable {
    let code: Int
    let msg: String
    let data: UserData
}
