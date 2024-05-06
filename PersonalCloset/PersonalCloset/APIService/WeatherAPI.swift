//
//  WeatherAPI.swift
//  PersonalCloset
//
//  Created by Bowon Han on 4/10/24.
//

import Foundation

enum WeatherAPI {
    static let baseURL = "http://3.35.233.65:8081/weather"
    
    case fetchWeatherStatus(_ latitudeValue: String, _ longtitudeValue: String)
}

extension WeatherAPI {
    var path: String {
        switch self {
        case .fetchWeatherStatus(let latitudeValue, let longtitudeValue):
            "/get/condition?latitude=\(latitudeValue)&longitude=\(longtitudeValue)"
        }
    }
    
    var method: String {
        switch self {
        case .fetchWeatherStatus:
            "GET"
        }
    }
    
    var url: URL {
        return URL(string: WeatherAPI.baseURL + path)!
    }
    
    var request: URLRequest {
        let token = TokenManager.shared.token.accessToken

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authentication")

        return request
    }
    
    func performRequest(with parameters: Encodable? = nil) async throws {
        /// URLRequest 생성
        var request = self.request

        if let parameters = parameters {
            request.httpBody = try JSONEncoder().encode(parameters)
        }
        
        print(request)

        /// 실제로 request를 보내서 network를 하는 부분
        let (data, response) = try await URLSession.shared.data(for: request)
        print(data)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw FetchError.invalidStatus
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            /// 성공적인 응답 처리
            let weatherStatus = String(decoding: data, as: UTF8.self)
            WeatherManager.shared.weather.weatherStatus = weatherStatus
            print("network 결과:",WeatherManager.shared.weather.weatherStatus)
        
        case 400..<600:
            /// 오류 응답 처리
            let dataContent = try JSONDecoder().decode(ServerStatus.self, from: data)
            print("Response Data: \(dataContent.message)")
            print("error: \(httpResponse.statusCode)")
        
        default:
            /// 그 외의 상태코드 처리
            throw FetchError.invalidStatus
        }
    }
}
