//
//  FindPwViewModel.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/30.
//

import Foundation
import Combine

class FindPwViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var errorMessage: String?
    @Published var isRequestSuccessful: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService = APIService()

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
    
    func sendPasswordRequest() {
        validateEmail()
        
        guard errorMessage == nil, !email.isEmpty else { return }

        apiService.findPassword(email: email)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = "비밀번호 찾기 요청에 실패했습니다: \(error.localizedDescription)"
                    self?.isRequestSuccessful = false
                }
            }, receiveValue: { [weak self] in
                self?.errorMessage = nil
                self?.isRequestSuccessful = true
            })
            .store(in: &cancellables)
    }
}
