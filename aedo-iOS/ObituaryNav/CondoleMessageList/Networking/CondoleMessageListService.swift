//
//  ObituaryMessageListService.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/05.
//

import Foundation
import RxSwift

protocol CondoleMessageListServiceProtocol {
    func fetchCondoleMessageList(of obId: String) -> Observable<[CondoleMessage]>
}

class CondoleMessageListService: CondoleMessageListServiceProtocol {
    func fetchCondoleMessageList(of obId: String) -> Observable<[CondoleMessage]> {
        return Observable.create { observer in
            var components = URLComponents(string: "\(Constant.BASE_URL)v1/condole")
            let id = URLQueryItem(name: "id", value: obId)
            components?.queryItems = [id]
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
                    observer.onError(GFError.invalidResponse)
                    return
                }
                
                if let data = data, let condoleMessageList = try? JSONDecoder().decode(CondoleMessageListResponse.self, from: data) {
                    observer.onNext(condoleMessageList.condoleMessage)
                    observer.onCompleted()
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

