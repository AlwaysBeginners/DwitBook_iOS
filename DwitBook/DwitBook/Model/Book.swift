//  Book.swift
//  DwitBook

import Foundation

struct Book: Codable {
    var id: Int
    var isbn: String
    var title: String
    var description: String
    var authorName: String
    var publisherName: String
    var publishedDate: String
    var category: String
    var thumbnailUrl: String
    
    init(id: Int,
         isbn: String,
         title: String,
         description: String,
         authorName: String,
         publisherName: String,
         publishedDate: String,
         category: String,
         thumbnailUrl: String
    ) {
        self.id = id
        self.isbn = isbn
        self.title = title
        self.description = description
        self.authorName = authorName
        self.publisherName = publisherName
        self.publishedDate = publishedDate
        self.category = category
        self.thumbnailUrl = thumbnailUrl
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case isbn
        case title
        case description
        case authorName = "author_name"
        case publisherName = "publisher_name"
        case publishedDate = "published_date"
        case category
        case thumbnailUrl = "thumbnail_url"
    }
}
