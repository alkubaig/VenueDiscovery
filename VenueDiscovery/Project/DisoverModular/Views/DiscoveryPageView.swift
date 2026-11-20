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
        static let pageTitle: String =  "Find your space"
        static let emptyViewTitle: String =  "EmptyView"
        static let headerHeight: CGFloat = 70
        static let headerSpacer: CGFloat = 1
    }
    
    @Environment(\.modelContext) private var modelContext
    @Query private var searchResults: [SearchResult]
    @Query private var userProfile: [UserProfile]
    @State private var showCitySearch = false
    var viewModel = VenuesListViewModel()

    init(viewModel: VenuesListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isDoneFetching {
                    titleView()
                    
                    searchView()
                    
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
                    .frame(width: 20, height: 20)
                    .font(.system(size: 12))
                    .foregroundStyle(Color(red: 0.35, green: 0.30, blue: 1.0))
               
                Text("Where and when?")
                    .font(.inter(size: 12, weight: .semibold))
                Spacer()
            }
            .foregroundStyle(.black)
            .padding(12)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray.opacity(0.25), lineWidth: 1)
            }
        }
        .frame(height: 59)
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
            .presentationBackground(.white)
        }
    }
    
   // Top header
    @ViewBuilder private func titleView() -> some View {
        VStack() {
            HStack {
                VStack() {
                    Text(searchResults.last?.userSelectedCity.uppercased() ?? "")
                        .font(.inter(size: 12, weight: .heavy))
                        .tracking(1.2)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Text(DiscoverPageConstants.pageTitle)
                        .font(.inter(size: 29, weight: .regular))
                        .tracking(-1.59)
                        .lineSpacing(0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
                
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
        }
        .frame(height: DiscoverPageConstants.headerHeight)
    }

    @ViewBuilder private func discoveryTableContent() -> some View {
        let selectedCity = searchResults.last?.userSelectedCity
        if let venues = viewModel.venues {
            let filteredVenues = venues.filter { venue in
                guard let selectedCity, !selectedCity.isEmpty else { return true }
                
                return venue.city.lowercased() == selectedCity.lowercased()
            }
            
            List(filteredVenues) { venue in
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

extension DiscoveryPageView {
    static var emptyPreview: some View {
        let viewModel = VenuesListViewModel()
        viewModel.isDoneFetching = true
        return DiscoveryPageView(viewModel: viewModel)
    }
    
    static var nonEmptyPreview: some View {
        let viewModel = VenuesListViewModel()
        viewModel.isDoneFetching = true
        viewModel.venues =
        [
            MockVenues.withImage,
            MockVenues.noImageNoRating,
            MockVenues.noImageWithRating
        ]
        return DiscoveryPageView(viewModel: viewModel)
    }
}

#Preview("empty preview") {
    DiscoveryPageView.emptyPreview
}

#Preview("non-empty preview") {
    DiscoveryPageView.nonEmptyPreview
}

