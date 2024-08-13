//
//  Date.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/06/05.
//

import Foundation

extension Date {
    
}

extension JSONDecoder {
    static var customDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        return decoder
    }
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}
