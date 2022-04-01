//
//  AutoLogInService.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/01.
//

import Foundation

class AutoLogInService {
    func autoLogIn(completion: @escaping ((Result<AutoLogInResponse, GFError>) -> Void)) {
        guard let url = URL(string:  "\(Constant.BASE_URL)v1/user/auto") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.PUT.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
                           
            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            if let data = data, let response = try? JSONDecoder().decode(AutoLogInResponse.self, from: data) {
                completion(.success(response))
                return
            }
            completion(.failure(.invalidData))
        }.resume()
    }
}
