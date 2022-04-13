//  SearchResultCell.swift
//  DwitBook

import UIKit
import RxSwift

class SearchResultCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var publishedYearLabel: UILabel!
    
    func bind(imageUrl: String, title: String, authorName: String, publishedYear: Int) {
        self.thumbnailImageView.image = ImageLoader.loadFromUrl(url: imageUrl)
        self.titleLabel.text = title
        self.authorNameLabel.text = authorName
        self.publishedYearLabel.text = "2018"
    }
    
}
