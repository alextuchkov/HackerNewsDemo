//
//  HackerNewsDemoApp.swift
//  HackerNewsDemo
//
//  Created by Oleksandr Tuchkov on 21.10.2024.
//

import SwiftUI
import SwiftData

@main
struct HackerNewsDemoApp: App {

    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .modelContainer(for: Item.self, inMemory: false) // Moved here
        }
    }
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }

}
