//
//  RegisterObituaryService.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/13.
//

import UIKit

class RegisterObituaryService {
    func uploadImage(request: RegisterObituaryRequest, image: UIImage, completion: @escaping ((Result<RegisterObituaryResponse, GFError>) -> Void)) {
        let parameters = [
            "relation": request.relation,
            "residentName": request.residentName,
            "residentphone": request.residentphone,
            "deceasedName": request.deceasedName,
            "deceasedAge": request.deceasedAge,
            "place": request.place,
            "eod": request.eod,
            "coffin": request.coffin,
            "dofp": request.dofp,
            "buried": request.buried,
            "word": request.word,
            "created": request.created
        ]
        
        guard let mediaImage = Media(withImgae: image, forKey: "img") else{ return }
        guard let url = URL(string: "\(Constant.BASE_URL)v1/obituary") else {
            completion(.failure(.invalidURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.POST.rawValue
        
        let boundary = "Boundary-\(UUID().uuidString)"
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(AccessToken.token, forHTTPHeaderField: Constant.ACCESSTOKEN_HEADERFIELD)
        let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
        urlRequest.httpBody = dataBody
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
                           
            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            if let data = data, let response = try? JSONDecoder().decode(RegisterObituaryResponse.self, from: data) {
                completion(.success(response))
                return
            }
            completion(.failure(.invalidData))
        }.resume()
    }
    
    func createDataBody(withParameters params: [String: Any]?, media: [Media]?, boundary: String) -> Data {
       let lineBreak = "\r\n"
       var body = Data()
       if let parameters = params {
          for (key, value) in parameters {
             body.append("--\(boundary + lineBreak)")
             body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
             body.append("\(value as! String + lineBreak)")
          }
       }
       if let media = media {
          for photo in media {
             body.append("--\(boundary + lineBreak)")
             body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
             body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
             body.append(photo.data!)
             body.append(lineBreak)
          }
       }
       body.append("--\(boundary)--\(lineBreak)")
       return body
    }

}

extension Data {
   mutating func append(_ string: String) {
      if let data = string.data(using: .utf8) {
         append(data)
      }
   }
}
