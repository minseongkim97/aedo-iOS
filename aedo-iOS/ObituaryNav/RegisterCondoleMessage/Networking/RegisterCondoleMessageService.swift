//
//  RegisterCondoleMessageService.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/17.
//

import Foundation

class RegisterCondoleMessageService {
    let now: String = {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: date)
        return dateString
    }()
    
    func registerCondoleMessage(content: String,
                                name: String,
                                obID: String,
                                completion: @escaping ((Result<CondoleMessage, GFError>) -> Void)
    ) {
        guard let url = URL(string: "\(Constant.BASE_URL)v1/user") else {
            completion(.failure(.invalidURL))
            return
        }
        
        // 실제 업로드할 (데이터)인스턴스 생성
        let registerCondoleMessageRequest = RegisterCondoleMessageRequest(title: content,
                                                                          content: name,
                                                                          created: now,
                                                                          obId: obID)
        
        // 모델을 JSON data 형태로 변환
        guard let jsonData = try? JSONEncoder().encode(registerCondoleMessageRequest) else {
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
            
            if let data = data, let response = try? JSONDecoder().decode(CondoleMessage.self, from: data) {
                completion(.success(response))
                return
            }
            completion(.failure(.invalidData))
        }.resume()
    }
}
