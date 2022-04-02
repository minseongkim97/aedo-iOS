//
//  AuthService.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/02.
//

import Foundation

class AuthService {
    func sendAuthNumber(at phoneNumber: String, completion: @escaping ((Result<SendAuthNumberResponse, GFError>) -> Void)) {
        guard let url = URL(string:  "\(Constant.BASE_URL)v1/user/sms") else {
            completion(.failure(.invalidURL))
            return
        }
        
        // 실제 업로드할 (데이터)인스턴스 생성
        let sendAuthNumberRequest = SendAuthNumberRequest(phone: phoneNumber)
        
        // 모델을 JSON data 형태로 변환
        guard let jsonData = try? JSONEncoder().encode(sendAuthNumberRequest) else {
            completion(.failure(.invalidRequest))
            return
        }
        
        // URL요청 생성
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // 요청타입 JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // 응답타입 JSON
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            if let data = data, let response = try? JSONDecoder().decode(SendAuthNumberResponse.self, from: data) {
                completion(.success(response))
                return
            }
            completion(.failure(.invalidData))
        }.resume()
    }
    
    
}
