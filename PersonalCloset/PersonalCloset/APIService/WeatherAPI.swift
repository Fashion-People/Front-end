//
//  WeatherAPI.swift
//  PersonalCloset
//
//  Created by Bowon Han on 4/10/24.
//

import Foundation

enum WeatherAPI {
    static let baseURL = "http://13.124.188.170:8081/weather"
    
    case fetchWeatherStatus(latitudeValue: String, longtitudeValue: String)
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
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
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
        
        /// response가 200번대인지 확인하는 부분
        if (200..<300).contains(httpResponse.statusCode) {
            /// Handle success (200번대)
            if case .fetchWeatherStatus = self {
                let weatherStatus = String(decoding: data, as: UTF8.self)
                WeatherManager.shared.weather.weatherStatus = weatherStatus
            }
            
            else {
                let dataContent = try JSONDecoder().decode(ServerStatus.self, from: data)
                print("Response Data: \(dataContent.message)")
            }
        }
        
        /// response가 400~600번대인지 확인하는 부분
        else if (400..<600).contains(httpResponse.statusCode) {
            let dataContent = try JSONDecoder().decode(ServerStatus.self, from: data)
            print("Response Data: \(dataContent.message)")
            print("error: \(httpResponse.statusCode)")
        }
    }
}
