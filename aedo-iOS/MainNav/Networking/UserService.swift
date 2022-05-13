//
//  UserService.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/14.
//

import Foundation

class UserService {
    
    func getUserInfo(completion: @escaping ((Result<User, GFError>) -> Void)) {
        
        guard let url = URL(string:  "\(Constant.BASE_URL)v1/user") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        print(AccessToken.token)
        request.setValue(AccessToken.token, forHTTPHeaderField: Constant.ACCESSTOKEN_HEADERFIELD)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
                           
            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            if let data = data, let user = try? JSONDecoder().decode(User.self, from: data) {
                completion(.success(user))
                return
            }
            completion(.failure(.invalidData))
        }.resume()
    }
}
