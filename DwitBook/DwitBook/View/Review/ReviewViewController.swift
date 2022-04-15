//  ReviewViewController.swift
//  DwitBook

import UIKit
import RxSwift

class ReviewViewController: UIViewController {
    
    var bookId: Int!
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var bookThumbnailImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishedYearLabel: UILabel!
    
    let viewModel = ReviewViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
