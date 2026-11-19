//
//  DiscoverPageView.swift
//  MyApp
//
//  Created by Ghadeer Alkubaish on 10/20/26.
//

import SwiftUI
import Lottie
import SwiftData

struct DiscoveryPageView: View {
    enum DiscoverPageConstants {
        static let pageTitle: String =  "Find Your Space"
        static let emptyViewTitle: String =  "EmptyView"
        static let headerHeight: CGFloat = 150
        static let headerSpacer: CGFloat = 1
    }
    
    @Environment(\.modelContext) private var modelContext
    @Query private var searchResults: [SearchResult]
    @Query private var userProfile: [UserProfile]
    @State private var showCitySearch = false
    
    @StateObject var viewModel = VenuesListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isDoneFetching {
                    titleView()
                    
                    discoveryTableContent()
                        .ignoresSafeArea()
                } else {
                    LottieView(animation: .named("discovery-skeleton"))
                        .playing(loopMode: .loop)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                }
            }
        }
        .navigationLinkIndicatorVisibility(.hidden)
        .ignoresSafeArea()
    }
    
    @ViewBuilder private func searchView() -> some View {
        Button {
            showCitySearch = true
        } label: {
            HStack {
                Image(systemName: "magnifyingglass")
                Text("Search city")
                Spacer()
            }
            .foregroundStyle(.gray)
            .padding(12)
            .background(Color.gray.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.horizontal)
        .sheet(isPresented: $showCitySearch) {
            CitySearchView() { city in
                let result = SearchResult(city: city)
                modelContext.insert(result)
                try? modelContext.save()
                showCitySearch = false
            }
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
        
    }
    
   // Top header
    @ViewBuilder private func titleView() -> some View {
        VStack() {
            Text(searchResults.last?.userSelectedCity ?? "")
                .font(.caption2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HStack {
                Text(DiscoverPageConstants.pageTitle)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text(userProfile.first?.initials ?? "")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(width: 40, height: 40)
                    .background {
                        Circle()
                            .fill(Color.black)
                    }
                    .padding(.trailing)
                
            }


            searchView()
        }
        .frame(height: DiscoverPageConstants.headerHeight)
    }

    @ViewBuilder private func discoveryTableContent() -> some View {
        if let venues = viewModel.venues {
            List(venues) { venue in
                NavigationLink(destination: VenueDetailsPage(venue: venue)) {
                    DiscoveryPageCellView(venue: venue)

                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
        } else {
            Text(DiscoverPageConstants.emptyViewTitle)
        }
    }
}

// MARK: preview
#Preview {
    DiscoveryPageView()
}
