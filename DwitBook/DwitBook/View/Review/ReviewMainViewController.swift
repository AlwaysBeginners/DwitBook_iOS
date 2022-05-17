//  ReviewViewController.swift
//  DwitBook

import UIKit
import RxSwift
import Alamofire

class ReviewMainViewController: UIViewController {
    
    var bookId: Int!
    
    @IBOutlet weak var bookThumbnailContainer: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var reviewContentScrollView: UIScrollView!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var favoriteSentenceLabel: UILabel!
    @IBOutlet weak var myCommentLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet var starImageViews: [UIImageView]!
    @IBOutlet weak var scrollViewTopConstraint: NSLayoutConstraint!
    
    let viewModel = ReviewViewModel()
    let disposeBag = DisposeBag()
    
    let halfStarImageName = "star.leadinghalf.filled"
    let fillStarImageName = "star.fill"
    let emptyStarImangeName = "star"
    
    var scrollViewMaxConstant: CGFloat!
    var scrollViewMinConstant: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setLeftBarButtonItem()
        setImages(url: "https://an2-img.amz.wtchn.net/image/v2/DazPm8nIPttHb3pwB7Ap2Q.jpg?jwt=ZXlKaGJHY2lPaUpJVXpJMU5pSjkuZXlKdmNIUnpJanBiSW1SZk5Ea3dlRGN3TUhFNE1DSmRMQ0p3SWpvaUwzWXlMM04wYjNKbEwySnZiMnN2TVRZME1EYzFPRFkyT0RBek56Y3pOalF6TkNKOS5PT0M3RE82aVV1VEtaNkF5dkJJNnVLbVNWN29hanE5VzVQQXQ3YUpNNlZz")
        
        ratingSlider.addTarget(self, action: #selector(ratingSliderAction), for: .valueChanged)
        
        scrollViewMaxConstant = 0
        scrollViewMinConstant = -view.frame.height * 0.37
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reviewContentScrollView.showsVerticalScrollIndicator = false
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
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
    
    private func setDelegate() {
        reviewContentScrollView.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func setImages(url: URLConvertible) {
        backgroundView.setImageByUrl(url: url)
        bookImageView.setImageByUrl(url: url)
        backgroundView.addBlurEffect(style: .systemThinMaterialDark)
        bookImageView.layer.cornerRadius = 5
    }
    
    private func setLeftBarButtonItem() {
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked(_:)))
        
        leftItem.tintColor = .white
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    private func addCreateReviewButton() {
        var createButton: UIButton {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width*0.45, height: 50))
            button.titleLabel?.text = "리뷰 작성하기"
            button.backgroundColor = .white
            button.tintColor = .buttonBorderColor
            button.setBorder(color: .buttonBorderColor, width: 1, radius: 15)
            return button
        }
    }
}

extension ReviewMainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentY = reviewContentScrollView.contentOffset.y
        let newConstant = scrollViewTopConstraint.constant - contentY
        
        if newConstant <= scrollViewMinConstant {
            self.navigationItem.title = "Testing"
            scrollViewTopConstraint.constant = scrollViewMinConstant
        }
        else if newConstant >= scrollViewMaxConstant {
            scrollViewTopConstraint.constant = scrollViewMaxConstant
        }
        else {
            if scrollViewMinConstant <= newConstant && newConstant <= scrollViewMaxConstant {
                self.navigationItem.title = ""
            }
            scrollViewTopConstraint.constant = newConstant
            reviewContentScrollView.contentOffset.y = 0
        }
        
    }
}

// Selector Functions
extension ReviewMainViewController {
    
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
