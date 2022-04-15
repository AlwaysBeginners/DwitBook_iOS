//  SearchViewModel.swift
//  DwitBook

import Foundation
import RxSwift

class SearchViewModel {
    private var searchResponse = SearchResponse.EMPTY
    private var suggestionResponse = SuggestionResponse.EMPTY
    
    func suggestionList(query: String) -> [String] {
        let response: SuggestionResponse = getSampleData(filename: "suggestionSampleData")
        return response.suggestionList
    }
    
    func searchResultList(query: String) -> [SearchResult] {
        let response: SearchResponse = getSampleData(filename: "searchResultSampleData")
        return response.resultList
    }
    
    func getSampleData<T: Codable>(filename: String) -> T {
        let data: Data
        
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("Can't find URL filename")
        }
        
        do {
            data = try Data(contentsOf: url)
        } catch {
            fatalError("Can't load to data")
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            fatalError("Can't decode data \(error)")
        }
    }
}
