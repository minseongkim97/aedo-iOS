//
//  PolicyDataService.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/03/31.
//

import Foundation

class PolicyService {
    func getPolicy(completion: @escaping ((Result<AllPolicy, GFError>) -> Void)) {
        guard let url = URL(string:  "\(Constant.BASE_URL)v1/app/policy") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
                           
            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            if let data = data, let policy = try? JSONDecoder().decode(AllPolicy.self, from: data) {
                completion(.success(policy))
                return
            }
            completion(.failure(.invalidData))
        }.resume()
    }
}
