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
    case fetchCloth(clothId: Int)
    case fetchAllClothes(memberId: String)
    case deleteCloth(clothId: Int)
    case createCloth(_ param: ClothRequestDTO)
    case modifyCloth(clothId: Int, _ param: ClothRequestDTO)
}

extension ClothesAPI {
    static let baseURL = "http://15.164.219.41:8081/clothes"
    
    var path: String {
        switch self {
        case .fetchCloth(let clothId),
            .deleteCloth(let clothId):
            return "/\(clothId)"
        case .createCloth:
            return "/save"
        case .fetchAllClothes(let memberId):
            return "/all/\(memberId)"
        case .modifyCloth(let clothId,_):
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
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyIiwicm9sZXMiOlsiVVNFUiJdLCJpYXQiOjE3MTAyNDcyNTYsImV4cCI6MTcxMDI1MDg1Nn0.m0GS3UQu3OeDPYmtz7lmrJcOJq2U52uEVJa-VuOBr78", forHTTPHeaderField: "Authentication")
        return request
    }
    
    func performRequest(with parameters: Encodable? = nil) async throws {
        //URLRequest 생성
        var request = self.request

        if let parameters = parameters {
            request.httpBody = try JSONEncoder().encode(parameters)
        }
        
        print(request)

        // 실제로 request를 보내서 network를 하는 부분
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw FetchError.invalidStatus
        }
        
        //response가 200번대인지 확인하는 부분
        if (200..<300).contains(httpResponse.statusCode) {
            if case .fetchAllClothes = self {
                let clothList = try JSONDecoder().decode([ClothListModel].self, from: data)
                print(clothList)
                
                ClothListManager.shared.clothList = clothList
            }
            else {
                let dataContent = try JSONDecoder().decode(ServerStatus.self, from: data)
                print("Response Data: \(dataContent.msg)")
            }
        }
        else if (400..<600).contains(httpResponse.statusCode) {
            // Handle client error (4xx)
            let dataContent = try JSONDecoder().decode(ServerStatus.self, from: data)
            print("Response Data: \(dataContent.msg)")
            print("error: \(httpResponse.statusCode)")
        }
    }

}
