//
//  AnnouncementService.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/03.
//

import Foundation

class AnnouncementService {
    
    func getAllAnnouncement(completion: @escaping ((Result<AnnouncementList, GFError>) -> Void)) {
        
        guard let url = URL(string:  "\(Constant.BASE_URL)v1/center/announcement") else {
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
            
            if let data = data, let allAnnouncement = try? JSONDecoder().decode(AnnouncementList.self, from: data) {
                completion(.success(allAnnouncement))
                return
            }
            completion(.failure(.invalidData))
        }.resume()
    }
}
