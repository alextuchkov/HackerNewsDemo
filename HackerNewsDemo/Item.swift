import SwiftUI
import SwiftData


class Item: Decodable, Identifiable {
    let id: Int
    let title: String
    let author: String
    let commentCount: Int
    let score: Int
    let url: String
    let date: Date

    
    
    init(id: Int, title: String, author: String, commentCount: Int, score: Int, url: String, date: Date) {
        self.id = id
        self.title = title
        self.author = author
        self.commentCount = commentCount
        self.score = score
        self.url = url
        self.date = date
      
        
    }
    
    // CodingKeys to map json to my model
    enum CodingKeys: String, CodingKey {
        case id, url, score, title
        case commentCount = "descendants"
        case date = "time"
        case author = "by"
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

@Model
class LocalItem {
    var id: Int
    var title: String
    var author: String
    var commentCount: Int
    var score: Int
    var url: String
    var date: Date
    
    var saved: Bool
    
    init(story:Item, saved: Bool) {
        self.id = story.id
        self.title = story.title
        self.author = story.author
        self.commentCount = story.commentCount
        self.score = story.score
        self.url = story.url
        self.date = story.date
        
        self.saved = true
    }
}

