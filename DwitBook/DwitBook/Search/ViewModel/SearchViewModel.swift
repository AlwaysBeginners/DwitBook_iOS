//  SearchViewModel.swift
//  DwitBook

import Foundation
import RxSwift

class SearchViewModel {
    private var searchResponse = SearchResponse.EMPTY
    private var suggestionResponse = SuggestionResponse.EMPTY
    
    func suggestionList(query: String) -> [String] {
        let data: Data
        
        guard let url = Bundle.main.url(forResource: "suggestionSampleData", withExtension: "json") else {
            fatalError("Can't find URL")
        }
        
        do {
            data = try Data(contentsOf: url)
        } catch {
            fatalError("Can't load to data")
        }
        
        do {
            return try JSONDecoder().decode(SuggestionResponse.self, from: data).suggestionList
        } catch {
            fatalError("Can't decode data")
        }
    }
    
    
}
