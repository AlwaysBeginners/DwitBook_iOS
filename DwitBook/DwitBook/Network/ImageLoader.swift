//  ImageLoader.swift
//  DwitBook

import Foundation
import Alamofire
import UIKit

struct ImageLoader {
    
    static func loadFromUrl(url: String) -> UIImage {
        var image = UIImage()
        AF
            .request(url, method: .get)
            .response { response in
                switch response.result {
                case .success(let success):
                    if let data = success,
                       let loadedImage = UIImage(data: data) {
                        image = loadedImage
                    }
                case .failure(let error):
                    print("Error during loading image: \(error)")
                }
        }
        
        return image
    }
    
}
