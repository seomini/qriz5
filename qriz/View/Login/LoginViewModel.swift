//
//  LoginViewModel.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/22.
//

import Foundation
import Combine

//class LoginViewModel: ObservableObject {
//    @Published var username: String = ""
//    @Published var password: String = ""
//    @Published var showAlert: Bool = false
//    @Published var alertMessage: String = ""
//
//
//    func login() {
//        if username.isEmpty || password.isEmpty {
//            alertMessage = "아이디와 비밀번호를 입력해 주세요."
//            showAlert = true
//        } else if username == "testuser" && password == "password123" {
//            alertMessage = "로그인 성공!"
//            showAlert = true
//        } else {
//            // Simulate a failed login
//            alertMessage = "로그인 실패: 아이디 혹은 비밀번호가 잘못되었습니다."
//            showAlert = true
//        }
//    }
//}

//class LoginViewModel: ObservableObject {
//    @Published var username: String = ""
//    @Published var password: String = ""
//    @Published var showAlert: Bool = false
//    @Published var alertMessage: String = ""
//
//    private var cancellables = Set<AnyCancellable>()
//    
//    @Published var hasLoginRecord: Bool = false //처음 로그인 했는지 여부
//    
//    func checkLoginRecord() {
//        // 실제로 로그인 기록이 있는지 확인하는 로직을 구현합니다.
//        // 예를 들어, UserDefaults 또는 Keychain에 저장된 데이터를 확인할 수 있습니다.
//        // 여기서는 예시로 UserDefaults를 사용하겠습니다.
//        
//        if let _ = UserDefaults.standard.string(forKey: "loginRecord") {
//            hasLoginRecord = true
//        } else {
//            hasLoginRecord = false
//        }
//    }
//    
//    func login() {
//        if username.isEmpty || password.isEmpty {
//            alertMessage = "아이디와 비밀번호를 입력해 주세요."
//            showAlert = true
//        } else {
//            APIService().login(username: username, password: password) { [weak self] result in
//                switch result {
//                case .success(let response):
//                    DispatchQueue.main.async {
//                        self?.alertMessage = response.msg
//                        self?.showAlert = true
//                    }
//                case .failure(let error):
//                    DispatchQueue.main.async {
//                        self?.alertMessage = "로그인 실패: \(error.localizedDescription)"
//                        self?.showAlert = true
//                    }
//                }
//            }
//        }
//    }
//}
class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var hasLoginRecord: Bool = false // 로그인 기록 여부

    private var cancellables = Set<AnyCancellable>()
    private let apiService = APIService()

    init() {
        checkLoginRecord()
    }
    
    func checkLoginRecord() {
        // UserDefaults를 사용하여 로그인 기록 확인
        if let _ = UserDefaults.standard.string(forKey: "loginRecord") {
            hasLoginRecord = true
        } else {
            hasLoginRecord = false
        }
    }
    
    func login() {
        if username.isEmpty || password.isEmpty {
            alertMessage = "아이디와 비밀번호를 입력해 주세요."
            showAlert = true
            return
        }
        
        apiService.login(username: username, password: password)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    // 요청이 완료되었으나, 성공/실패는 receiveValue에서 처리됨
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.alertMessage = "로그인 실패: \(error.localizedDescription)"
                        self?.showAlert = true
                    }
                }
            }, receiveValue: { [weak self] response in
                DispatchQueue.main.async {
                    self?.alertMessage = response.msg
                    self?.showAlert = true
                    
                    // 로그인 성공 시 UserDefaults에 로그인 기록 저장
                    UserDefaults.standard.set("loggedIn", forKey: "loginRecord")
                }
            })
            .store(in: &cancellables)
    }
}
