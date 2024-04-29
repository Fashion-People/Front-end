//
//  FitnessTestAPI.swift
//  PersonalCloset
//
//  Created by Bowon Han on 4/10/24.
//

import Foundation

enum FitnessTestAPI {
    static let baseURL = "http://43.202.51.16:8081"
    
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
        /// URLRequest 생성
        var request = self.request

        if let parameters = parameters {
            request.httpBody = try JSONEncoder().encode(parameters)
        }
        
        /// request URL
        print(request)

        /// 실제로 request를 보내서 network를 하는 부분
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw FetchError.invalidStatus
        }
        
        /// response status가 200번대인지 확인하는 부분
        if (200..<300).contains(httpResponse.statusCode) {
            if case .fitnessTest = self {
                let clothList = try JSONDecoder().decode([ClothListModel].self, from: data)
                
                ClothListManager.shared.clothList = clothList
            }
        }
        
        /// respones가 오류임을 나타낼때
        else if (400..<600).contains(httpResponse.statusCode) {
            let dataContent = try JSONDecoder().decode(ServerStatus.self, from: data)
            print("Response Data: \(dataContent.message)")
            print("error: \(httpResponse.statusCode)")
        }
    }
}
