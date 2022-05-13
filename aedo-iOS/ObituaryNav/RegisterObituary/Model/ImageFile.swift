//
//  ImageFile.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/13.
//

import UIKit


struct Media {
    let key: String
    let filename: String
    let data: Data?
    let mimeType: String
    
    init?(withImgae image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "image.jpeg"
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        self.data = data
    }
}
