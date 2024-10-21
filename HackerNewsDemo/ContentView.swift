import SwiftUI

struct ContentView: View {
    
    
            var body: some View {
                TabView {
                    ListView(type:"beststories", navtitle: "Best")
                        .tabItem {
                            Label("Best", systemImage: "hand.thumbsup")
                        }
                    
//                    ListView(type:"topstories", navtitle: "Top")
//                        .tabItem {
//                            Label("Top", systemImage: "star")
//                        }
                    
                    ListView(type:"newstories", navtitle: "New")
                        .tabItem {
                            Label("New", systemImage: "flame")
                        }
                    SavedListView()
                        .tabItem {
                            Label("Saved", systemImage: "bookmark")
                        }
                }
            }
        }
        

#Preview {
    ContentView()
}
