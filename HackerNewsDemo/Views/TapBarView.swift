//
//  TapBarView.swift
//  HackerNewsDemo
//
//  Created by Oleksandr Tuchkov on 22.10.2024.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case best = "hand.thumbsup"
    case new = "flame"
    case saved = "bookmark"
}

struct TapBarView: View {
    @Binding var selectedTab: Tab

    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }

    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Spacer()
                Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                    .font(.largeTitle)
                    .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                    .foregroundColor(selectedTab == tab ? .orange : .gray)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            selectedTab = tab
                        }
                    }
                Spacer()
            }
        }
        .frame(height: 60)
        .background(.thinMaterial)
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    TapBarView(selectedTab: .constant(.best))
}
