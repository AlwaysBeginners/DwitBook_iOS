//  SearchResultCell.swift
//  DwitBook

import UIKit
import RxSwift
import Alamofire

class SearchResultCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailCustomView: ShadowedImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var publishedYearLabel: UILabel!
    
    var shadowLayer: CAShapeLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBorder(color: .lightGray.withAlphaComponent(0.4), width: 1, radius: 10)
        contentView.setBorder(color: .lightGray.withAlphaComponent(0.4), width: 1, radius: 10)
        layer.masksToBounds = false
    }
    
    func bind(item: SearchResult) {
        self.thumbnailCustomView.imageView.setImageByUrl(url: item.thumbnailUrl)
        self.titleLabel.text = item.title
        self.authorNameLabel.text = item.authorName
        self.publishedYearLabel.text = String(describing: item.publishedDate.year)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
            shadowLayer.fillColor = self.backgroundColor?.cgColor

            shadowLayer.shadowOpacity = 0.1
            shadowLayer.shadowRadius = 4
            shadowLayer.shadowOffset = CGSize(width: 0, height: 3)

            self.layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
}
