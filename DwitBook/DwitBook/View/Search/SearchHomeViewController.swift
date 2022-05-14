//  SearchHomeViewController.swift
//  DwitBook

import UIKit
import Lottie

class SearchHomeViewController: UIViewController {

    @IBOutlet weak var lottieAnimationView: AnimationView!
    @IBOutlet weak var searchBarShapeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLottieAnimationSetting()
        setSearchBarShpaeButtonAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func searchBarShapeButtonClicked(_ sender: Any) {
        if let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
            searchVC.isInitial = true
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    private func setLottieAnimationSetting() {
        lottieAnimationView.loopMode = .autoReverse
        lottieAnimationView.backgroundBehavior = .pauseAndRestore
        lottieAnimationView.play(completion: nil)
    }
    
    private func setSearchBarShpaeButtonAppearance() {
        searchBarShapeButton.layer.borderWidth = 2
        searchBarShapeButton.layer.cornerRadius = searchBarShapeButton.frame.height * 0.5
        searchBarShapeButton.layer.borderColor = UIColor(named: "MainColor")?.cgColor
    }
    
}
