//  Review.swift
//  DwitBook

import Foundation

struct ReviewResponse: NetworkResponse, Codable {
    var statusCode: Int
    var book: Book
//    var review: Review
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case book
//        case
    }
}

struct Review: Codable {
    var id: Int
    var accountId: Int
    var bookId: Int
    var rating: Float
    var favoriteSentence: String
    var comment: String
    
    var createdDate: Date
    var updatedDate: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case accountId = "account_id"
        case bookId = "book_id"
        case rating
        case favoriteSentence = "favorite_sentence"
        case comment
        case createdDate = "created_date"
        case updatedDate = "updated_date"
    }
}
