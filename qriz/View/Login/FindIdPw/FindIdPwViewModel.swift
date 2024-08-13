//
//  FindIdPwViewModel.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/23.
//

import Foundation

class FindIdPwViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var id: String = ""
    @Published var email: String = ""
    @Published var verificationCode: String = ""
    
}
