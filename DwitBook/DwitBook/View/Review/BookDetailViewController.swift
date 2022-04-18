//  ReviewViewController.swift
//  DwitBook

import UIKit
import RxSwift

class BookDetailViewController: UIViewController {
    
    var bookId: Int!
    
    @IBOutlet weak var bookInfoStackView: UIStackView!
    @IBOutlet weak var thumbnailCustomView: ShadowedImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishedYearLabel: UILabel!
    
    let viewModel = ReviewViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBarButtonItem()
        
    }
    
    private func setLeftBarButtonItem() {
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "lasso"), style: .plain, target: self, action: #selector(backButtonClicked(_:)))
        leftItem.tintColor = UIColor(named: "MainColor")
        
        self.navigationController?.navigationItem.leftBarButtonItem = leftItem
    }
    
    @objc func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
