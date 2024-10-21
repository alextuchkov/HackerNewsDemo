//
//  BestNewsView.swift
//  HackerNewsDemo
//
//  Created by Oleksandr Tuchkov on 21.10.2024.
//

import SwiftUI

struct ListView: View {
    @State var viewModel = ViewModel()
    let type: String
    let navtitle: String
    
    var body: some View {
        NavigationView {
            List(viewModel.stories) { story in
                ItemView(story: story)
            }
            .listStyle(.plain)
            .navigationTitle("10 \(navtitle)")
            .refreshable {
                do {
                    try await viewModel.getBestStories(withType: type)
                } catch {
                    print("Failed to refresh stories: \(error.localizedDescription)")
                }
            }
            .task {
                do {
                    try await viewModel.getBestStories(withType: type) // Fetch stories when view loads
                } catch {
                    print("Failed to load stories: \(error.localizedDescription)")
                }
            }
        }
    }
}
