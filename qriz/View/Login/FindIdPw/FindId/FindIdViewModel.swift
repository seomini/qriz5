//
//  FindIdViewModel.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/30.
//

import Foundation
import Combine

class FindIdViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var errorMessage: String?
    @Published var isEmailSent: Bool = false
    @Published var emailSendError: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService = APIService()

    func sendEmail() {
        validateEmail()
        
        guard errorMessage == nil, !email.isEmpty else { return }

        apiService.findUsername(nickname: "sampleNickname", email: email)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.isEmailSent = false
                    self?.emailSendError = "이메일 발송에 실패했습니다. 다시 시도해 주세요."
                    print("Error sending email: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] response in
                self?.isEmailSent = true
                self?.emailSendError = nil
                self?.errorMessage = nil
                print("Username sent: \(response.data.username)")
            })
            .store(in: &cancellables)
    }

    func validateEmail() {
        if email.isEmpty {
            errorMessage = "이메일을 입력해주세요."
        } else if !isValidEmail(email) {
            errorMessage = "이메일 형식이 올바르지 않습니다."
        } else {
            errorMessage = nil
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
