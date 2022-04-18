//  ShadowedImageView.swift
//  DwitBook

import UIKit
import Alamofire

class ShadowedImageView: UIView {

    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImageView()
        self.setShadowAndBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setImageView()
        self.setShadowAndBorder()
    }
    
    public func setImage(url: URLConvertible) {
        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let responseData):
                self.imageView.image = UIImage(data: responseData!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setShadowAndBorder() {
        self.imageView.setBorder()
        self.setShadow()
    }
    
    private func setImageView() {
        self.imageView = UIImageView()
        self.imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

}
