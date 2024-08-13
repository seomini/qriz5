//
//  EmailAuthenticationResponse.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/08/07.
//

import Foundation

struct EmailAuthenticationResponse: Codable {
    let code: String
    let msg: String
    let data: ResponseData?

    struct ResponseData: Codable {
        // API 응답의 data 필드가 null이거나 비어있을 수 있기 때문에 이 구조체는 비어 있습니다.
    }
}
