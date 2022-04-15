//  SearchViewController.swift
//  DwitBook

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet var filterButtons: [UIButton]!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    var suggestionTableView = UITableView()
    var activityIndicator = UIActivityIndicatorView()
    
    var isInitial: Bool!
    var passedQuery: String?
    var timer: Timer?
    
    var suggestionList = BehaviorSubject<[String]>(value: [])
    var searchResultList = BehaviorSubject<[SearchResult]>(value: [])
    
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setActivityIndicatorView()
        addSearchBarViewBottomBorder()
        setFilterButtonsAppearance()
        addSuggestionTableView()
        setSearchTextField()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isInitial {
            searchTextField.becomeFirstResponder()
            resultView.isHidden = true
        } else {
            searchTextField.text = passedQuery
            searchAction()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        self.suggestionTableView.isHidden = true
    }
    
    private func setDelegate() {
        searchTextField.delegate = self
        resultCollectionView.delegate = self
    }
    
    func setActivityIndicatorView() {
        activityIndicator.style = .medium
        activityIndicator.center = resultView.center
        self.view.addSubview(activityIndicator)
    }
    
    func pushSearchVC(query: String) {
        
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let searchVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        searchVC.isInitial = false
        searchVC.passedQuery = query
        
        self.navigationController?.pushViewController(searchVC, animated: false)
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterButtonClicked(_ sender: UIButton) {
        // parameter 바꿔서 다시 요청
        sender.backgroundColor = UIColor(named: "MainColor")?.withAlphaComponent(0.2)
        
        switch sender.tag {
            
        case 0:
            //유사도순 search
            searchAction()
            filterButtons[1].backgroundColor = .white
            break
        case 1:
            //출간일순 search
            searchAction()
            filterButtons[0].backgroundColor = .white
            break
        default:
            return
            
        }
    }
    
}


//TextField feature
extension SearchViewController: UITextFieldDelegate {
    
    private func setSearchTextField() {
        searchTextField.returnKeyType = .search
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let query = searchTextField.text else {return false}
        
        pushSearchVC(query: query)
        
        return true
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        timer?.invalidate()
        
        if searchTextField.text != "" {
            timer = .scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
                guard let query = self?.searchTextField.text else {return}
                self?.bindSuggestionsToTableView(query: query)
                self?.suggestionTableView.isHidden = false
            }
        } else {
            suggestionTableView.isHidden = true
        }
    }
    
}

// Appearance feature
extension SearchViewController {
    private func addSearchBarViewBottomBorder() {
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: searchBarView.frame.height, width: searchBarView.frame.width, height: 1.5)
        bottomLayer.backgroundColor = UIColor(named: "MainColor")?.cgColor
        
        searchBarView.layer.addSublayer(bottomLayer)
    }
    
    private func setFilterButtonsAppearance() {
        filterButtons[0].backgroundColor = UIColor(named: "MainColor")?.withAlphaComponent(0.2)
        
        filterButtons.forEach { button in
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor(named: "MainColor")?.cgColor
            button.layer.cornerRadius = button.frame.height * 0.48
        }
    }
}
