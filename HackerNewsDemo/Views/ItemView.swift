//
//  ItemView.swift
//  HackerNewsDemo
//
//  Created by Oleksandr Tuchkov on 21.10.2024.
//
import SwiftUI
import SwiftData

struct ItemView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    let story: Item
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8.0) {
                Text(story.title)
                    .font(.headline)
                
                HStack {
                    Text(story.displayURL)
                        .foregroundColor(.blue)
                    Text(" - \(story.relativeDate) -")
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
            Image(systemName: "bookmark")
                .font(.title)
        }
        .padding(.vertical, 8)
        .swipeActions {
            Button {
                let newLocalStory = LocalItem(story:story, saved: true)
                context.insert(newLocalStory)
                do {
                    try context.save()
                } catch {
                    print("Failed to save context after deletion: \(error)")
                }
                dismiss()
                
            } label: {
                Label("Bookmark", systemImage: "bookmark.fill")
            }
            .tint(.orange)
        }
    }
}



extension Item {
    // Helper to format the URL without the "https://" part
    var displayURL: String {
        URL(string: url)?.host ?? url
    }
    
    // Helper to format the date as a relative time (e.g., "3 days ago")
    var relativeDate: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}


#Preview {
    ItemView(story: Item.story) 
}
