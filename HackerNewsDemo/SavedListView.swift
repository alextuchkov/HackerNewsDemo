//
//  SavedListView.swift
//  HackerNewsDemo
//
//  Created by Oleksandr Tuchkov on 21.10.2024.
//

import SwiftUI
import SwiftData

struct SavedListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \LocalItem.date) private var localItems: [LocalItem]
    
    @State private var viewModel = LocalItemsViewModel()
    
    var body: some View {
        NavigationView {
            List(localItems) { story in
                LocalItemView(story: story)
            }
            .listStyle(.plain)
            .navigationTitle("Saved stories")
            .onAppear {
                // Assuming you have an array of Item to pass in
                let items: [Item] = [] // Replace this with your actual items
                viewModel.addItems(from: items)
            }
        }
    }
}

    


#Preview {
    SavedListView()
}

struct LocalItemView: View {
    var story: LocalItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8.0) {
                Text(story.title)
                    .font(.headline)
                
                HStack {
                    Text(story.url)
                        .foregroundColor(.blue)
                    //                    Text(" - \(story.relativeDate) -")
                    Text("by: \(story.author)")
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                
                HStack {
                    Label("\(story.score)", systemImage: "arrowtriangle.up.circle.fill")
                        .foregroundStyle(.blue)
                    
                    Spacer()
                    
                    Label("\(story.commentCount)", systemImage: "bubble.right.fill")
                        .foregroundStyle(.orange)
                }
                .font(.footnote)
                .labelStyle(.titleAndIcon)
            }
            if story.saved {
                Image(systemName: "bookmark.fill")
                    .font(.title)
            } else {
                Image(systemName: "bookmark")
                    .font(.title)
            }
        }
        .padding(.vertical, 8)
    }
}
