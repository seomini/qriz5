//
//  PathType.swift
//  qriz
//

import Foundation

enum PathType: Hashable {
    case signUpView
    case findIdView
    case findPwView
}

//회원가입 화면
enum SignUpStep {
    case name, email,emailok, id, password
    
    func next() -> SignUpStep {
        switch self {
        case .name: return .email
        case .email: return .emailok
        case .emailok: return .id
        case .id: return .password
        case .password: return .name
        }
    }
    
    func previous() -> SignUpStep {
        switch self {
        case .name: return .name
        case .email: return .name
        case .emailok: return .email
        case .id: return .emailok
        case .password: return .id
        }
    }
}

enum MyPagePathType: Hashable {
    case registView
}
