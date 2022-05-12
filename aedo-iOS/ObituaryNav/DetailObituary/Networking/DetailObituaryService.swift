//
//  DetailObituaryService.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/08.
//

import Foundation
import RxSwift

protocol DetailObituaryServiceProtocol {
    func fetchDetailObituaryList(name: String) -> Observable<[ObituaryResponse]>
}

class DetailObituaryService: DetailObituaryServiceProtocol {
    func fetchDetailObituaryList(name: String) -> Observable<[ObituaryResponse]> {
        return Observable.create { observer in
            var components = URLComponents(string: "\(Constant.BASE_URL)v1/obituary")
            let name = URLQueryItem(name: "name", value: name)
            components?.queryItems = [name]
            guard let url = components?.url else {
                observer.onError(GFError.invalidURL)
                return Disposables.create {}
            }
            var request = URLRequest(url: url)
            request.setValue(AccessToken.token, forHTTPHeaderField: Constant.ACCESSTOKEN_HEADERFIELD)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let _ = error {
                    observer.onError(GFError.networkError)
                    return
                }
                               
                guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                    print("invalid response error")
                    observer.onError(GFError.invalidResponse)
                    return
                }
                
                if let data = data, let obituaryList = try? JSONDecoder().decode(ObituaryListResponse.self, from: data) {
                    observer.onNext(obituaryList.result)
                    return
                }
                observer.onError(GFError.invalidData)
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

