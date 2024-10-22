//
//  LocalItemView.swift
//  HackerNewsDemo
//
//  Created by Oleksandr Tuchkov on 22.10.2024.
//
import SwiftUI
import SwiftData

struct LocalItemView: View {
    var story: LocalItem
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
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
        .swipeActions {
            Button {
                toggleSavedStatus(for: story)
                
                do {
                    try context.save()
                } catch {
                    print("Failed to save context after deletion: \(error)")
                }
                dismiss()
                
            } label: {
                Label("Delete", systemImage: "trash.fill")
            }
            .tint(.red)
        }
        
    }
    private func toggleSavedStatus(for item: LocalItem) {
        item.saved.toggle()
    }
}




