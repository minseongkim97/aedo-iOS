//
//  InquiryService.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/12.
//

import Foundation

class InquiryService {
    
    func getInquiryList(completion: @escaping ((Result<InquiryList, GFError>) -> Void)) {
        
        guard let url = URL(string:  "\(Constant.BASE_URL)v1/center/request") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
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
            
            if let data = data, let inquiryList = try? JSONDecoder().decode(InquiryList.self, from: data) {
                completion(.success(inquiryList))
                return
            }
            completion(.failure(.invalidData))
        }.resume()
    }
}
