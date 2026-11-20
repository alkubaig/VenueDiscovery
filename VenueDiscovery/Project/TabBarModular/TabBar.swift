//
//  TabBar.swift
//  MyApp
//
//  Created by Ghadeer Alkubaish on 10/20/26.
//

import SwiftUI
import Playgrounds
import SwiftData

struct AppTabBar: View {
    @StateObject var viewModel = VenuesListViewModel()
    
    var body: some View {
        TabView {
            Tab("Discover", systemImage: "magnifyingglass") {
                DiscoveryPageView(viewModel: viewModel)
            }

            Tab("Account", systemImage: "person.circle") {
                AccountPageView(viewModel: viewModel)
            }
        }
        .modelContainer(for: [
            SearchResult.self,
            UserProfile.self,
            FavoriteVenue.self
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
