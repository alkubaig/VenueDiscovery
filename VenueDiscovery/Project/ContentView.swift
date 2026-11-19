import SwiftUI
import Playgrounds
import SwiftData

struct ContentView: View {
    
    var body: some View {
        TabView {
            Tab("Discover", systemImage: "magnifyingglass") {
                DiscoveryPageView()
            }

            Tab("Account", systemImage: "person.circle") {
                AccountPageView()
            }
        }
        .modelContainer(for: [
            SearchResult.self,
            UserProfile.self
        ])
    }
}

// MARK: preview
#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
