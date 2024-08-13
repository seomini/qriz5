//
//  ApplyListResponse.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/08/09.
//

import Foundation

struct ApplyListResponse: Codable {
    let code: Int
    let msg: String
    let data: [ApplyItem]
    
    struct ApplyItem: Codable {
        let apply_id: Int
        let period: String
        let date: String
        let test_time: String
    }
}
