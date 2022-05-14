//  ReviewViewController.swift
//  DwitBook

import UIKit
import RxSwift

class ReviewMainViewController: UIViewController {
    
    var bookId: Int!
    
    @IBOutlet weak var bookThumbnailContainer: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var favoriteSentenceLabel: ReviewBlockView!
    @IBOutlet weak var myCommentLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet var starImageViews: [UIImageView]!
    
    
    let viewModel = ReviewViewModel()
    let disposeBag = DisposeBag()
    
    let halfStarImageName = "star.leadinghalf.filled"
    let fillStarImageName = "star.fill"
    let emptyStarImangeName = "star"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        setLeftBarButtonItem()
        bookImageView.layer.cornerRadius = 5
        
        ratingSlider.addTarget(self, action: #selector(ratingSliderAction), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? BookDetailViewController {
            detailVC.bookId = self.bookId
        }
    }
    
    private func setLeftBarButtonItem() {
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked(_:)))
        
        leftItem.tintColor = UIColor(named: "MainColor")
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    @objc func ratingSliderAction() {
        let value = Int(ratingSlider.value)
        
        for starImageView in starImageViews {
            
            if value/2 >= starImageView.tag {
                starImageView.image = UIImage(systemName: fillStarImageName)
            } else if value/2 == starImageView.tag - 1 && value%2 == 1 {
                starImageView.image = UIImage(systemName: halfStarImageName)
            } else if value/2 < starImageView.tag {
                starImageView.image = UIImage(systemName: emptyStarImangeName)
            }
        }
    }
    
    @objc func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
