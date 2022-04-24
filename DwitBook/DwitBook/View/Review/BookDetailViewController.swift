//  ReviewViewController.swift
//  DwitBook

import UIKit
import RxSwift

class BookDetailViewController: UIViewController {
    
    var bookId: Int!
    
    @IBOutlet weak var bookThumbnailContainer: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    
    let viewModel = ReviewViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBarButtonItem()
        bookThumbnailContainer.backgroundColor = UIColor(patternImage: UIImage(named: "sample")!)
        bookThumbnailContainer.addBlurEffect()
        bookImageView.layer.cornerRadius = 5
    }
    
    @IBAction func bookInfoButtonClicked(_ sender: Any) {
        
    }
    
    private func setLeftBarButtonItem() {
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "lasso"), style: .plain, target: self, action: #selector(backButtonClicked(_:)))
        leftItem.tintColor = UIColor(named: "MainColor")
        
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    @objc func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
