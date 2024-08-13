//
//  AuthenticationViewModel.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/07/11.
//

import Foundation
import Combine

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {
    
    enum Action {
        case googleLogin
    }
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var isLoading = false
    
    
    
    var userId: String?
    
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
        case .googleLogin:
            isLoading = true
            
            container.services.authService.signInWithGoogle()
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.isLoading = false
                    }
                } receiveValue: { [weak self] user in
                    self?.isLoading = false
                    self?.userId = user.userId
                    self?.authenticationState = .authenticated
                }
                .store(in: &subscriptions)
        }
    }
    
    func checkAuthenticationState() {
        // 여기에 사용자 인증 상태를 확인하는 로직을 추가할 수 있습니다.
        // 예를 들어, 토큰을 저장하고 있다면 이를 검증하는 로직을 추가합니다.
    }
}
