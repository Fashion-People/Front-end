//
//  TokenAPI.swift
//  PersonalCloset
//
//  Created by Bowon Han on 3/12/24.
//

import Foundation

enum TokenAPI {
    static let authenticationURL = "http://43.201.109.28:8081/user"
    
    case login (_ id: String,_ password: String)
    case join (_ param: UserRequestDTO)
}
    
extension TokenAPI {
    var path: String{
        switch self {
        case .login(let id, let password):
            return "/login?loginId=\(id)&password=\(password)"
        case .join:
            return "/join"
        }
    }
    
    var method: String {
        switch self {
        case .login,
             .join:
            return "POST"
        }
    }
    
    var url: URL {
        return URL(string: TokenAPI.authenticationURL + path)!
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func performRequest(with parameters: Encodable? = nil) async throws -> Bool {
        var successCheck: Bool = false
        /// URLRequest 생성
        var request = self.request
        print(request)
        
        if let parameters = parameters {
            request.httpBody = try JSONEncoder().encode(parameters)
        }
        
        /// 실제로 request를 보내서 network를 하는 부분
        let (data, response) = try await URLSession.shared.data(for: request)
        print(data)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw FetchError.invalidStatus
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            /// 성공적인 응답 처리
        
            /// Login 로직
            if case .login = self {
                let loginToken = String(decoding: data, as: UTF8.self)
                TokenManager.shared.token.accessToken = loginToken
                successCheck = true
            }
            
            /// Join 로직
            else if case .join = self {
                let dataContent = try JSONDecoder().decode(ServerStatus.self, from: data)
                print("Response Data: \(dataContent.message)")
                successCheck = true
            }
        
        case 400..<600:
            /// 오류 응답 처리
            let dataContent = try JSONDecoder().decode(ServerStatus.self, from: data)
            print("Response Data: \(dataContent.message)")
            print("error: \(httpResponse.statusCode)")
            successCheck = false
        
        default:
            /// 그 외의 상태코드 처리
            throw FetchError.invalidStatus
        }
        
        return successCheck
    }
}
