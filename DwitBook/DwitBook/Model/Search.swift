//  Suggestion.swift
//  DwitBook

import Foundation

protocol NetworkResponse {
    var statusCode: Int { get }
}

struct SearchResponse: NetworkResponse, Codable {
    var statusCode: Int
    var resultList: [Book]
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case resultList = "items"
    }
    
    static let EMPTY = SearchResponse(statusCode: 0, resultList: [])
}

struct SuggestionResponse: NetworkResponse, Codable {
    var statusCode: Int
    var suggestionList: [String]
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case suggestionList = "suggestions"
    }
    
    static let EMPTY = SuggestionResponse(statusCode: 0, suggestionList: [])
}
