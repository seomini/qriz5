//
//  APIService.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/08/06.
//

import Foundation
import Combine

struct UserData: Codable {
    let id: Int
    let username: String
    let createdAt: String
}



class APIService {
    private let baseURL = "https://yourapi.com/api"
    private var cancellables = Set<AnyCancellable>()
    
    func login(username: String, password: String) -> AnyPublisher<LoginResponse, NetworkError> {
        guard let url = URL(string: "\(baseURL)/login") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginRequest = LoginRequest(username: username, password: password)
        
        do {
            let requestBody = try JSONEncoder().encode(loginRequest)
            request.httpBody = requestBody
        } catch {
            return Fail(error: NetworkError.encodingError(error)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: LoginResponse.self, decoder: JSONDecoder())
            .mapError { error in
                if let urlError = error as? URLError {
                    return NetworkError.urlError(urlError)
                } else if let decodingError = error as? DecodingError {
                    return NetworkError.decodingError(decodingError)
                } else {
                    return NetworkError.other(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func findUsername(nickname: String, email: String) -> AnyPublisher<FindIdResponse, NetworkError> {
        guard let url = URL(string: "\(baseURL)/find-username") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let findIdRequest = FindIdRequest(nickname: nickname, email: email)
        
        do {
            let requestBody = try JSONEncoder().encode(findIdRequest)
            request.httpBody = requestBody
        } catch {
            return Fail(error: NetworkError.encodingError(error)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: FindIdResponse.self, decoder: JSONDecoder())
            .mapError { error in
                if let urlError = error as? URLError {
                    return NetworkError.urlError(urlError)
                } else if let decodingError = error as? DecodingError {
                    return NetworkError.decodingError(decodingError)
                } else {
                    return NetworkError.other(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func findPassword(email: String) -> AnyPublisher<Void, NetworkError> {
        guard let url = URL(string: "\(baseURL)/find-pwd") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let findPwdRequest = FindPwdRequest(username: "", email: email)
        
        do {
            let requestBody = try JSONEncoder().encode(findPwdRequest)
            request.httpBody = requestBody
        } catch {
            return Fail(error: NetworkError.encodingError(error)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .map { _ in () } // 성공 응답을 Void로 변환
            .mapError { error in
                if let urlError = error as? URLError {
                    return NetworkError.urlError(urlError)
                } else if let decodingError = error as? DecodingError {
                    return NetworkError.decodingError(decodingError)
                } else {
                    return NetworkError.other(error)
                }
            }
            .eraseToAnyPublisher()
    }
    func sendEmail(email: String) -> AnyPublisher<EmailAuthenticationResponse, NetworkError> {
           guard let url = URL(string: "\(baseURL)/v1/email-send") else {
               return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
           }

           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")

           let sendEmailRequest = SendEmailRequest(email: email)

           do {
               let requestBody = try JSONEncoder().encode(sendEmailRequest)
               request.httpBody = requestBody
           } catch {
               return Fail(error: NetworkError.encodingError(error)).eraseToAnyPublisher()
           }

           return URLSession.shared.dataTaskPublisher(for: request)
               .map(\.data)
               .decode(type: EmailAuthenticationResponse.self, decoder: JSONDecoder())
               .mapError { error in
                   if let urlError = error as? URLError {
                       return NetworkError.urlError(urlError)
                   } else if let decodingError = error as? DecodingError {
                       return NetworkError.decodingError(decodingError)
                   } else {
                       return NetworkError.other(error)
                   }
               }
               .eraseToAnyPublisher()
       }
    
    // 이메일 인증 API
    func authenticateEmail(code: String) -> AnyPublisher<EmailAuthenticationResponse, NetworkError> {
        let url = URL(string: "\(baseURL)/api/email-authentication")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = EmailAuthenticationRequest(code: code)
        request.httpBody = try? JSONEncoder().encode(requestBody)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: EmailAuthenticationResponse.self, decoder: JSONDecoder())
            .mapError { error in
                if let urlError = error as? URLError {
                    return NetworkError.urlError(urlError)
                } else if let decodingError = error as? DecodingError {
                    return NetworkError.decodingError(decodingError)
                } else {
                    return NetworkError.other(error)
                }
            }
            .eraseToAnyPublisher()
    }
    // 아이디 중복 확인
    func checkUsernameDuplicate(username: String) -> AnyPublisher<UsernameDuplicateResponse, NetworkError> {
            guard let url = URL(string: "\(baseURL)/api/username-duplicate") else {
                return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let requestBody = UsernameDuplicateRequest(username: username)
            request.httpBody = try? JSONEncoder().encode(requestBody)

            return URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: UsernameDuplicateResponse.self, decoder: JSONDecoder())
                .mapError { error in
                    if let urlError = error as? URLError {
                        return NetworkError.urlError(urlError)
                    } else if let decodingError = error as? DecodingError {
                        return NetworkError.decodingError(decodingError)
                    } else {
                        return NetworkError.other(error)
                    }
                }
                .eraseToAnyPublisher()
        }
    
    // 회원가입 메서드
    func register(joinRequest: JoinRequest) -> AnyPublisher<JoinResponse, Error> {
        let url = URL(string: "\(baseURL)/join")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let requestBody = try JSONEncoder().encode(joinRequest)
            request.httpBody = requestBody
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: JoinResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    //온보딩
    func submitSurvey(request: SurveyRequest) -> AnyPublisher<SurveyResponse, Error> {
        guard let url = URL(string: baseURL) else {
            return Fail(error: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
                .eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let requestData = try JSONEncoder().encode(request)
            urlRequest.httpBody = requestData
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: SurveyResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    // 시험 접수 목록 불러오기
    func fetchApplyList() -> AnyPublisher<ApplyListResponse, Error> {
        let url = URL(string: "\(baseURL)/v1/application-list")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ApplyListResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - NetworkError

enum NetworkError: Error {
    case invalidURL
    case encodingError(Error)
    case urlError(URLError)
    case decodingError(DecodingError)
    case other(Error)
}
