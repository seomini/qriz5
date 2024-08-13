//
//  SurveyResponse.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/08/09.
//

import Foundation

struct SurveyResponse: Codable {
    let code: Int
    let msg: String
    let data: [SurveyData]
    
    struct SurveyData: Codable {
        let userId: String
        let skillId: Int
        let checked: Bool
        
        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case skillId = "skill_id"
            case checked
        }
    }
}
