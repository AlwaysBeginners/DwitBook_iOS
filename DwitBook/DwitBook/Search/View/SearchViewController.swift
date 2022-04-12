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
    
    var isInitial: Bool!
    var passedText: String?
    var timer: Timer?
    
    var suggestionList = BehaviorSubject<[String]>(value: [])
//    var searchResultList = BehaviorSubject<[String]>(value: [])
    
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        addSearchBarViewBottomBorder()
        setFilterButtonsAppearance()
        addSuggestionTableView()
        setSearchTextField()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isInitial {
            resultView.isHidden = true
        } else {
            searchTextField.text = passedText
            // Search Request
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        suggestionTableView.isHidden = true
    }
    
    private func setDelegate() {
        searchTextField.delegate = self
    }
    
    private func searchAction(query: String) {
        
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let searchVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        searchVC.isInitial = false
        searchVC.passedText = query
        
        self.navigationController?.pushViewController(searchVC, animated: false)
    }
    
    private func addSuggestionTableView() {
        view.addSubview(suggestionTableView)
        
        suggestionTableView.rowHeight = 50
        suggestionTableView.keyboardDismissMode = .onDrag
        
        // set constraints as same as result view
        suggestionTableView.translatesAutoresizingMaskIntoConstraints = false
        suggestionTableView.topAnchor.constraint(equalTo: resultView.topAnchor).isActive = true
        suggestionTableView.leadingAnchor.constraint(equalTo: resultView.leadingAnchor).isActive = true
        suggestionTableView.trailingAnchor.constraint(equalTo: resultView.trailingAnchor).isActive = true
        suggestionTableView.bottomAnchor.constraint(equalTo: resultView.bottomAnchor).isActive = true
        
        // register custom cell nib
        let nib = UINib(nibName: "SuggestionCell", bundle: nil)
        suggestionTableView.register(nib, forCellReuseIdentifier: "SuggestionCell")
        
        suggestionTableView.isHidden = true
    }
    
    private func bindSuggestionsToTableView(query: String) {
        suggestionList.onNext(viewModel.suggestionList(query: query))
        suggestionTableView.dataSource = nil // for binding new datasource
        
        _ = suggestionList
            .bind(to: suggestionTableView.rx.items(cellIdentifier: "SuggestionCell", cellType: SuggestionCell.self)) { index, element, cell in
                cell.bind(text: element)
            }
            .disposed(by: disposeBag)
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterButtonClicked(_ sender: UIButton) {
        // parameter 바꿔서 다시 요청
        
        sender.backgroundColor = UIColor(named: "MainColor")?.withAlphaComponent(0.2)
        
        switch sender.tag {
            
        case 0:
            filterButtons[1].backgroundColor = .white
            break
        case 1:
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
        
        searchAction(query: query)
        
        return true
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        timer?.invalidate()
        
        if searchTextField.text != "" {
            timer = .scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
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
