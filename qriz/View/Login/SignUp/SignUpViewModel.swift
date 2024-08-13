//
//  SignUpViewModel.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/23.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var userId: String = ""
    @Published var certificationId: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var certificationNumber: String = "" // 사용자 입력 인증 코드
    
    @Published var showNameError: Bool = false
    @Published var showEmailError: Bool = false
    @Published var showUserIdError: Bool = false
    @Published var showcertificationIdError: Bool = false
    @Published var showPasswordError: Bool = false
    @Published var showConfirmPasswordError: Bool = false
    
    @Published var isEmailSent: Bool = false
    @Published var emailSentError: String?
    @Published var isEmailAuthenticated: Bool = false
    @Published var emailAuthenticationError: String?
    
    @Published var userIdCheckError: String?
    @Published var isUserIdAvailable: Bool = false
    
    // 타이머 관련
    @Published var timerText: String = "3:00"
    @Published var isTimerRunning: Bool = false
    @Published var isTimerExpired: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService = APIService()
    private var serverAuthCode: String? // 서버에서 받은 인증 코드 저장
    private var timer: AnyCancellable?
    private var remainingSeconds = 180
    
    // 회원가입
    @Published var registrationSuccess: Bool = false
    @Published var registrationError: String?
    
    // 입력된 이름 검증
    func validateName() {
        showNameError = name.isEmpty
    }
    
    // 입력된 이메일 검증
    func validateEmail() {
        showEmailError = email.isEmpty || !email.contains("@")
    }
    
    // 입력된 사용자 ID 검증
    func validateUserId() {
        showUserIdError = userId.isEmpty
    }
    
    // 입력된 비밀번호 검증
    func validatePassword() {
        showPasswordError = password.isEmpty
    }
    
    // 비밀번호 확인 검증
    func validateConfirmPassword() {
        showConfirmPasswordError = confirmPassword.isEmpty || confirmPassword != password
    }

    // 모든 필드 검증
    func validateFields() {
        validateName()
        validateEmail()
        validateUserId()
        validatePassword()
        validateConfirmPassword()
    }
    
    // 타이머 시작
    func startTimer() {
        isTimerRunning = true
        isTimerExpired = false
        remainingSeconds = 180
        updateTimerText()
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.remainingSeconds -= 1
                self.updateTimerText()
                
                if self.remainingSeconds <= 0 {
                    self.timer?.cancel()
                    self.isTimerRunning = false
                    self.isTimerExpired = true
                    self.timerText = "시간이 만료되었습니다."
                }
            }
    }
    
    // 타이머 텍스트 업데이트
    private func updateTimerText() {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        timerText = String(format: "%d:%02d", minutes, seconds)
    }

    // 이메일 발송 요청
    func sendEmail() {
        validateEmail()
        guard !showEmailError else { return }
        
        apiService.sendEmail(email: email)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    DispatchQueue.main.async {
                        self.isEmailSent = true
                        self.emailSentError = nil
                        self.startTimer()  // 이메일 전송 후 타이머 시작
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.emailSentError = "이메일 전송에 실패했습니다: \(error.localizedDescription)"
                        self.isEmailSent = false
                    }
                }
            }, receiveValue: { response in
                // 서버에서 받은 인증 코드 저장
                self.serverAuthCode = response.code
            })
            .store(in: &cancellables)
    }
    
    // 이메일 인증 검증
    func authenticateEmail() {
        guard !isTimerExpired else {
            self.emailAuthenticationError = "인증 시간이 만료되었습니다."
            self.isEmailAuthenticated = false
            return
        }
        
        guard let serverAuthCode = serverAuthCode else {
            self.emailAuthenticationError = "인증 코드가 서버에서 수신되지 않았습니다."
            self.isEmailAuthenticated = false
            return
        }
        
        // 사용자가 입력한 인증 코드와 서버에서 받은 인증 코드 비교
        if certificationNumber == serverAuthCode {
            DispatchQueue.main.async {
                self.isEmailAuthenticated = true
                self.emailAuthenticationError = nil
            }
        } else {
            DispatchQueue.main.async {
                self.emailAuthenticationError = "인증 코드가 올바르지 않습니다."
                self.isEmailAuthenticated = false
            }
        }
    }
    // 아이디 중복 검증
    func checkUserIdDuplicate() {
        guard !userId.isEmpty else {
            showUserIdError = true
            return
        }

        apiService.checkUsernameDuplicate(username: userId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.userIdCheckError = "아이디 중복 확인에 실패했습니다: \(error.localizedDescription)"
                    }
                }
            }, receiveValue: { response in
                DispatchQueue.main.async {
                    self.isUserIdAvailable = response.data.available
                    self.userIdCheckError = response.data.available ? nil : "이미 사용 중인 아이디입니다."
                }
            })
            .store(in: &cancellables)
    }
    //회원가입
    func register() {
        validateFields()

        guard !showNameError, !showEmailError, !showUserIdError, !showPasswordError, !showConfirmPasswordError else {
            return
        }

        guard isEmailAuthenticated else {
            registrationError = "이메일 인증이 완료되지 않았습니다."
            return
        }

        let joinRequest = JoinRequest(
            username: userId,
            password: password,
            nickname: name,
            email: email
        )

        apiService.register(joinRequest: joinRequest)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.registrationError = "회원가입에 실패했습니다: \(error.localizedDescription)"
                    }
                }
            }, receiveValue: { response in
                if response.code == 1 {
                    DispatchQueue.main.async {
                        self.registrationSuccess = true
                        self.registrationError = nil
                    }
                } else {
                    DispatchQueue.main.async {
                        self.registrationError = response.msg
                    }
                }
            })
            .store(in: &cancellables)
    }
}
