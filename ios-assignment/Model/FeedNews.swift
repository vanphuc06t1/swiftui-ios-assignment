//
//  FeedNews.swift
//  ios-assignment
//
//  Created by Phuc Bui  on 8/29/21.
//

import Foundation

struct FeedNews: Identifiable, Decodable, Hashable {
    
    let id: Int
    let title: String
    let sourceName: String
    let imageURL: String
    let text: String
    let date: String
    let newsURL: String
    let contents: [FeedContentNews]
    
    private enum CodingKeys : String, CodingKey {
        case id,
             sourceName = "source_name",
             imageURL = "image_url",
             text,
             title,
             date,
             newsURL = "news_url",
             contents = "contents"
    }
}

struct FeedContentNews: Identifiable, Decodable, Hashable {
    
    let id: Int
    let title: String
    let text: String
    let imageURL: String
    let imageDescription: String
    let content: String
    
    private enum CodingKeys : String, CodingKey {
        case id,
             imageURL = "image_url",
             title,
             text,
             imageDescription = "image_description",
             content
    }
}

