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
        self.contentView.setBorder()
        
        // shadow
        self.setShadow()
    }
    
    func bind(item: SearchResult) {
        self.thumbnailCustomView.setImage(url: item.thumbnailUrl)
        self.titleLabel.text = item.title
        self.authorNameLabel.text = item.authorName
        self.publishedYearLabel.text = String(describing: item.publishedDate.year)
    }
    
}
