//
//  LocalItemsViewModel.swift
//  HackerNewsDemo
//
//  Created by Oleksandr Tuchkov on 21.10.2024.
//

import SwiftUI

@Observable
@MainActor
class LocalItemsViewModel {
    var localStories: [LocalItem] = []

    // Method to initialize localStories from an array of Item instances
    func addItems(from items: [Item]) {
        localStories = items.map { LocalItem(story: $0, saved: true) }
    }
}
