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
        bookImageView.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = .lightGray.withAlphaComponent(0.25)
    }
    
    @IBAction func bookInfoButtonClicked(_ sender: Any) {
        
    }
    
    private func setLeftBarButtonItem() {
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked(_:)))
        
        leftItem.tintColor = UIColor(named: "MainColor")
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    @objc func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
