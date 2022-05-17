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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // border
        self.setBorder(color: .lightGray.withAlphaComponent(0.4), width: 1, radius: 10)
        
        // shadow
        self.setShadow()
    }
    
    func bind(item: SearchResult) {
        self.thumbnailCustomView.imageView.setImageByUrl(url: item.thumbnailUrl)
        self.titleLabel.text = item.title
        self.authorNameLabel.text = item.authorName
        self.publishedYearLabel.text = String(describing: item.publishedDate.year)
    }
    
}
