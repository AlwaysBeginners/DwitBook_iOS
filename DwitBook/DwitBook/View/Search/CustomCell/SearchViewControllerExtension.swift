//  SearchViewControllerExtension.swift
//  DwitBook

import Foundation
import UIKit
import RxSwift

// Result CollectionView feature
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func searchAction() {
        guard let query = passedQuery else {return}
        searchResultList.onNext(viewModel.searchResultList(query: query))
        setResultCollectionView()
    }
    
    func setResultCollectionView() {
        resultCollectionView.dataSource = nil
        
        // collection view datasource
        _ = searchResultList.bind(to: resultCollectionView.rx.items(cellIdentifier: "SearchResultCell", cellType: SearchResultCell.self)) { index, element, cell in
            
            cell.bind(item: element)
            
        }
        .disposed(by: disposeBag)
        
        // cell selection event
        _ = resultCollectionView.rx.modelSelected(Book.self)
            .subscribe(onNext: { [weak self] book in
                // push book review page
                //self?.pushReviewVC(bookId: Int)
            })
            .disposed(by: disposeBag)
    }
    
    // cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.45
        let height = width * 1.8
        return CGSize(width: width, height: height)
    }
    
    // collectionView inset
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}

// Suggestion TableView feature
extension SearchViewController {
    
    func addSuggestionTableView() {
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
    
    func bindSuggestionsToTableView(query: String) {
        suggestionList.onNext(viewModel.suggestionList(query: query))
        suggestionTableView.dataSource = nil // for binding new datasource
        
        _ = suggestionList
            .bind(to: suggestionTableView.rx.items(cellIdentifier: "SuggestionCell", cellType: SuggestionCell.self)) { index, element, cell in
                cell.bind(text: element)
            }
            .disposed(by: disposeBag)
        
        // cell selection event
        _ = suggestionTableView.rx.modelSelected(String.self)
            .subscribe(onNext: { [weak self] query in
                self?.pushSearchVC(query: query)
            })
            .disposed(by: disposeBag)
    }
    
}
