//  SearchResultCell.swift
//  DwitBook

import UIKit
import RxSwift
import Alamofire

class SearchResultCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var publishedYearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // border
        self.contentView.setBorder()
        
        // shadow
        self.setShadow()
        
        thumbnailImageView.setBorder()
    }
    
    func bind(item: SearchResult) {
        AF.request("https://bookthumb-phinf.pstatic.net/cover/206/335/20633531.jpg?udate=20211231", method: .get).response { response in
            switch response.result {
            case .success(let responseData):
                self.thumbnailImageView.image = UIImage(data: responseData!)
            case .failure(let error):
                print(error)
            }
        }
        self.titleLabel.text = item.title
        self.authorNameLabel.text = item.authorName
        self.publishedYearLabel.text = String(describing: item.publishedDate.year)
    }
    
}
