//
//  TermService.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/02.
//

import Foundation

class TermService {
    func getTerm(completion: @escaping ((Result<Term, GFError>) -> Void)) {
        guard let url = URL(string:  "\(Constant.BASE_URL)v1/app/terms") else {
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
            
            if let data = data, let term = try? JSONDecoder().decode(Term.self, from: data) {
                completion(.success(term))
                return
            }
            completion(.failure(.invalidData))
        }.resume()
    }
}
