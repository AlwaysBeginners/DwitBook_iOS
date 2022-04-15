//  Suggestion.swift
//  DwitBook

import Foundation

protocol NetworkResponse {
    var statusCode: Int { get }
}

struct SearchResponse: NetworkResponse, Codable {
    var statusCode: Int
    var resultList: [SearchResult]
    
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

struct SearchResult: Codable {
    var id: Int
    var thumbnailUrl: String
    var title: String
    var authorName: String
    var publishedDate: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case thumbnailUrl = "thumbnail_url"
        case title
        case authorName = "author_name"
        case publishedDate = "published_date"
    }
}
