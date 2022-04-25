//  UIImageExtension.swift
//  DwitBook

import Foundation
import UIKit
import Alamofire

extension UIImageView {
    func setImageByUrl(url: URLConvertible) {
        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let responseData):
                self.image = UIImage(data: responseData!)
            case .failure(let error):
                print("Error occured during AF: \(error)")
            }
        }
    }
}
