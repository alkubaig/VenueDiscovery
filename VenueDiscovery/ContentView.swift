import SwiftUI
import Playgrounds

struct ContentView: View {
    
    var body: some View {
        DiscoveryPageView()
            .ignoresSafeArea()
    }
}

// MARK: preview
#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
