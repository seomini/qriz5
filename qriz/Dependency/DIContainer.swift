//
//  DIContainer.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/07/11.
//

import Foundation

class DIContainer: ObservableObject {
    var services: ServiceType
    
    init(services: ServiceType) {
        self.services = services
    }
}
