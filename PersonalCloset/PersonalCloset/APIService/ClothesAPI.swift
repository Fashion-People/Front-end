//
//  ClothesAPI.swift
//  PersonalCloset
//
//  Created by Bowon Han on 3/12/24.
//

import Foundation

enum FetchError: Error {
    case invalidStatus
    case jsonDecodeError
}

enum ClothesAPI {
    static let baseURL = "http://43.201.61.246:8081/clothes"

    case fetchCloth(clothesNumber: Int)
    case fetchAllClothes
    case deleteCloth(clothId: Int)
    case createCloth
    case modifyCloth(clothId: Int)
}

extension ClothesAPI {
    var path: String {
        switch self {
        case .fetchCloth(let clothId),
            .deleteCloth(let clothId):
            return "/\(clothId)"
        case .createCloth:
            return "/save"
        case .fetchAllClothes:
            return "/all"
        case .modifyCloth(let clothId):
            return "/update/\(clothId)"
        }
    }
    
    var method: String {
        switch self {
        case .fetchCloth,
            .fetchAllClothes:
            return "GET"
        case .createCloth:
            return "POST"
        case .deleteCloth:
            return "DELETE"
        case .modifyCloth:
            return "PUT"
        }
    }
    
    var url: URL {
        return URL(string: ClothesAPI.baseURL + path)!
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
            if case .fetchAllClothes = self {
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
