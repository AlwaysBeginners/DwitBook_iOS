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
    @IBOutlet weak var filterButtonContainer: UIView!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    var suggestionTableView = UITableView()
    var activityIndicator = UIActivityIndicatorView()
    
    var isInitial: Bool!
    var passedQuery: String?
    var timer: Timer?
    
    var suggestionList = BehaviorRelay<[String]>(value: [])
    var searchResultList = BehaviorRelay<[SearchResult]>(value: [])
    
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        setDelegate()
        setActivityIndicatorView()
        setBottomBorder()
        setFilterButtonsAppearance()
        addSuggestionTableView()
        setSearchTextField()
        
        bindResultCollectionView()
        bindSuggestionTableView()
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
        searchTextField.resignFirstResponder()
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
        searchVC.passedQuery = query.removeForwardWhiteSpaces()
        
        self.navigationController?.pushViewController(searchVC, animated: false)
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterButtonClicked(_ sender: UIButton) {
        // parameter 바꿔서 다시 요청
        sender.backgroundColor = .mainColor.withAlphaComponent(0.1)
        
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
        
        guard let searchFieldText = searchTextField.text else {return}
        
        if !searchFieldText.onlyWhiteSpace {
            timer = .scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
                self?.suggestionTableView.isHidden = false
                
                let query = searchFieldText.removeForwardWhiteSpaces()
                
                guard let newSuggestionData = self?.viewModel.suggestionList(query: query) else {return}
                
                self?.suggestionList.accept(newSuggestionData)
                
                self?.suggestionTableView.isHidden = false
            }
        } else {
            suggestionTableView.isHidden = true
        }
    }
    
}

// Appearance feature
extension SearchViewController {
    private func setBottomBorder() {
        searchBarView.addBottomBorder(color: .mainColor, lineWidth: 1.5)
//        filterButtonContainer.addBottomBorder(color: .mainColor, lineWidth: 1)
    }
    
    private func setFilterButtonsAppearance() {
        filterButtons[0].backgroundColor = .mainColor.withAlphaComponent(0.1)
        
        filterButtons.forEach { button in
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor.mainColor.cgColor
            button.layer.cornerRadius = button.frame.height * 0.48
        }
        
    }
}
