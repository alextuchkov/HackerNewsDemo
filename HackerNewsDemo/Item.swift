//
//  Item.swift
//  HackerNewsDemo
//
//  Created by Oleksandr Tuchkov on 21.10.2024.
//

import SwiftUI
import SwiftData


class ItemDTO: Decodable, Identifiable {
    let id: Int
    let title: String
    let author: String
    let commentCount: Int
    let score: Int
    let url: String
    let date: Date


    // CodingKeys to map json to my model
    enum CodingKeys: String, CodingKey {
        case id, url, score, title
        case commentCount = "descendants"
        case date = "time"
        case author = "by"
    }
}



@Model
class Item: Identifiable {
    var id: Int
    var title: String
    var author: String
    var commentCount: Int
    var score: Int
    var url: String
    var date: Date
    var saved: Bool
    
    init(id: Int, title: String, author: String, commentCount: Int, score: Int, url: String, date: Date, saved: Bool = false) {
        self.id = id
        self.title = title
        self.author = author
        self.commentCount = commentCount
        self.score = score
        self.url = url
        self.date = date
        self.saved = saved
    }
    
// Convert from DTO to Item
    convenience init(from dto: ItemDTO) {
        self.init(id: dto.id, title: dto.title, author: dto.author, commentCount: dto.commentCount, score: dto.score, url: dto.url, date: dto.date)
    }
}


// extension with static mock item
extension Item {
    static let story = Item(
        id: 1,
        title: "Some story title",
        author: "alex",
        commentCount: 10,
        score: 42,
        url: "https://example.com",
        date: Date()
    )
}

