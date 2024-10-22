//
//  ListView.swift
//  HackerNewsDemo
//
//  Created by Oleksandr Tuchkov on 21.10.2024.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @State var viewModel = ViewModel()
    @Environment(\.modelContext) private var context
    
    let type: String?
    let navtitle: String
    // special flag to use on Bookmark View
    var showSavedItems: Bool = false
    
    // Query for saved items
    @Query(filter: #Predicate { $0.saved == true }, sort: \Item.date) private var savedItems: [Item]
    
    var body: some View {
        NavigationView {
            if showSavedItems {
                List(savedItems) { story in
                    ItemView(story: story)
                }
                .listStyle(.plain)
                .navigationTitle("Saved stories")
            } else {
                List(viewModel.stories) { story in
                    ItemView(story: story)
                }
                .listStyle(.plain)
                .navigationTitle("10 \(navtitle)")
                .refreshable {
                    do {
                        try await viewModel.getBestStories(withType: type ?? "", context: context)
                    } catch {
                        print("Failed to refresh stories: \(error.localizedDescription)")
                    }
                }
                .task {
                    do {
                        try await viewModel.getBestStories(withType: type ?? "", context: context)
                    } catch {
                        print("Failed to load stories: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

#Preview {
    ListView(type: "beststories", navtitle: "Best", showSavedItems: false)
}
