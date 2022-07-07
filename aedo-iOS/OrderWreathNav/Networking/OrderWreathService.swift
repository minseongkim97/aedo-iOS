//
//  OrderWreathService.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/06/29.
//

import Foundation
class OrderWreathService {
    func orderWreath(wreath: Wreath, completion: @escaping ((Result<OrderWreathResponse, GFError>) -> Void)) {
        guard let url = URL(string: "\(Constant.BASE_URL)v1/order") else {
            completion(.failure(.invalidURL))
            return
        }
        
        // 실제 업로드할 (데이터)인스턴스 생성
        let wreath = Wreath(place: wreath.place,
                            receiver: wreath.receiver,
                            sender: wreath.sender,
                            word: wreath.word,
                            item: wreath.item,
                            price: wreath.price,
                            created: wreath.created)
        
        // 모델을 JSON data 형태로 변환
        guard let jsonData = try? JSONEncoder().encode(wreath) else {
            completion(.failure(.invalidRequest))
            return
        }
        
        // URL요청 생성
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.setValue(AccessToken.token, forHTTPHeaderField: Constant.ACCESSTOKEN_HEADERFIELD)
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
            
            if let data = data, let response = try? JSONDecoder().decode(OrderWreathResponse.self, from: data) {
                completion(.success(response))
                return
            }
            completion(.failure(.invalidData))
        }.resume()
    }

}
