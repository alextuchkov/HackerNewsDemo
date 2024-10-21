//
//  ViewModel.swift
//  HackerNewsDemo
//
//  Created by Oleksandr Tuchkov on 21.10.2024.
//

import SwiftUI

@Observable
@MainActor
class ViewModel {
    var stories: [Item] = []
    
//
    
    func getBestStories(withType type:String) async throws {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/\(type).json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let ids = try JSONDecoder().decode([Int].self, from: data)
//            print("Story IDs: \(ids)")
            
            var fetchedStories: [Item] = []
            
            // Use TaskGroup for concurrent fetching of stories
            try await withThrowingTaskGroup(of: Item.self) { group in
                for id in ids.prefix(10) {
                    group.addTask {
                        try await self.getStory(withID: id)
                    }
                }
                
                // Collect all results
                for try await story in group {
                    fetchedStories.append(story)
                }
            }
            
            self.stories = fetchedStories
//            print("Fetched stories: \(fetchedStories)")
       
        } catch {
            print("Failed to fetch or decode data: \(error.localizedDescription)")
            throw error // Propagate error for handling upstream
        }
    }
    
    private func getStory(withID id: Int) async throws -> Item {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
//        if let jsonString = String(data: data, encoding: .utf8) {
//            print("Received JSON for story \(id): \(jsonString)")
//        }
        
        let decoder = JSONDecoder()
        // Use date decoding strategy if the date is a timestamp
        decoder.dateDecodingStrategy = .secondsSince1970
        
        return try decoder.decode(Item.self, from: data)
    }
}
