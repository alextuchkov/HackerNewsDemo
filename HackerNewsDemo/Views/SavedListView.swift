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
    @Query(filter: #Predicate { $0.saved == true }, sort: \LocalItem.date) private var localItems: [LocalItem]
    
    @State private var viewModel = LocalItemsViewModel()
    
    var body: some View {
        NavigationView {
            List(localItems) { story in
                LocalItemView(story: story)
            }
            .listStyle(.plain)
            .navigationTitle("Saved stories")
            .onAppear {
                
                let items: [Item] = [] 
                viewModel.addItems(from: items)
            }
        }
    }
}



    


#Preview {
    SavedListView()
}


