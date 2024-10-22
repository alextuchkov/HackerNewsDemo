//
//  ContentView.swift
//  HackerNewsDemo
//
//  Created by Oleksandr Tuchkov on 21.10.2024.
//

import SwiftUI

struct ContentView: View {
    @State var splashActive: Bool = false
    @State private var selectedTab: Tab = .best

    // i remove default tapbar appearance
    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack {
            if self.splashActive {
                ZStack {
                    VStack {
                        TabView(selection: $selectedTab) {
                            ListView(type: "beststories", navtitle: "Best", showSavedItems: false)
                                .tag(Tab.best)
                            ListView(type: "newstories", navtitle: "New", showSavedItems: false)
                                .tag(Tab.new)
                            ListView(type: nil, navtitle: "Saved", showSavedItems: true)
                                .tag(Tab.saved)
                        }
                    }

                    VStack {
                        Spacer()
                        TapBarView(selectedTab: $selectedTab)
                    }
                }
                .transition(.opacity) // Add transition for smoother splash exit
            } else {
                VStack {
                    Text("Hacker News")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                }
                .transition(.opacity) // Transition for splash screen appearance
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    self.splashActive = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
