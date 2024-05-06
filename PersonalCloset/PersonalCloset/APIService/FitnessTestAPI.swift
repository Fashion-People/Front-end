//
//  FitnessTestAPI.swift
//  PersonalCloset
//
//  Created by Bowon Han on 4/10/24.
//

import Foundation

enum FitnessTestAPI {
    static let baseURL = "http://3.35.233.65:8081"
    
    case fitnessTest
}

extension FitnessTestAPI {
    var path: String {
        switch self {
        case .fitnessTest:
            "/analysis"
        }
    }
    
    var method: String {
        switch self {
        case .fitnessTest:
            "POST"
        }
    }
    
    var url: URL {
        return URL(string: FitnessTestAPI.baseURL + path)!
    }
    
    var request: URLRequest {
        let token = TokenManager.shared.token.accessToken
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authentication")
        return request
    }
    
    // MARK: - network 호출함수
    func performRequest(with parameters: Encodable? = nil) async throws {
        print("request 함수 호출 시점")
        /// URLRequest 생성
        var request = self.request
        
        /// 요청에 파라미터 추가
        if let parameters = parameters {
            request.httpBody = try JSONEncoder().encode(parameters)
            print(parameters)
        }
        
        /// request URL
        print(request)
        
        /// 네트워크 요청 및 데이터 수신
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw FetchError.invalidStatus
        }
        
        /// response status 확인
        switch httpResponse.statusCode {
        case 200..<300:
            /// 성공적인 응답 처리
            if case .fitnessTest = self {
                let result = try JSONDecoder().decode(FitnessTestModel.self, from: data)
                FitnessTestManager.shared.result = result
                print(result)
            } else {
                throw FetchError.invalidStatus
            }
            
        case 400..<600:
            /// 오류 응답 처리
            let dataContent = try JSONDecoder().decode(ServerStatus.self, from: data)
            print("Response Data: \(dataContent.message)")
            print("Error: \(httpResponse.statusCode)")
            throw FetchError.invalidStatus
            
        default:
            /// 그 외의 상태코드 처리
            throw FetchError.invalidStatus
        }
    }
}
