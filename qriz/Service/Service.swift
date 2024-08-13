//
//  ServiceType.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/07/11.
//

import Foundation

protocol ServiceType {
    var authService: AuthenticationServiceType { get set }
}

class Services: ServiceType {
    var authService: AuthenticationServiceType
    
    init() {
        self.authService =  AuthenticationService()
    }
}

class StubService: ServiceType {
    var authService: AuthenticationServiceType =  StubAuthenticationService()
}


