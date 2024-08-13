//
//  ChangePwViewModel.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/06/04.
//

import SwiftUI
import Combine

class ChangePwViewModel: ObservableObject {
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String?

    func validatePasswords() {
        if newPassword.isEmpty || confirmPassword.isEmpty {
            errorMessage = "모든 필드를 채워주세요."
        } else if newPassword != confirmPassword {
            errorMessage = "비밀번호가 일치하지 않습니다."
        } else {
            errorMessage = nil
        }
    }

    func changePassword() {
        validatePasswords()
        if errorMessage == nil {
            // 비밀번호 변경 로직 서버에 요청을 보내 비밀번호를 변경로직 구현
        }
    }
}
