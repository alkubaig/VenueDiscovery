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
    enum Constants {
        static let pageTitle: String =  "Find your space"
        static let emptyViewTitle: String =  "EmptyView"
        static let headerHeight: CGFloat = 70
        static let searchBarHeight: CGFloat = 59
        static let headerSpacer: CGFloat = 1
        static let searchTabText = "Where and when?"
        static let searchIconSize: CGFloat = 20
        static let initialViewHeight: CGFloat = 38
        static let initialViewWidth: CGFloat = 38

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
            VStack(spacing: .none) {
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
                Image(systemName: appIcons.magnifyingGlass)
                    .frame(width: Constants.searchIconSize, height: Constants.searchIconSize)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.blueIcon)
                
                VStack(alignment: .leading) {
                    Text(Constants.searchTabText)
                        .font(.inter(size: appFontSize.body, weight: .semibold))
                        .foregroundColor(.blackText)
                   
                    Text(searchResults.last?.userSelectedCity ?? "")
                        .font(.inter(size: appFontSize.small, weight: .regular))
                        .foregroundColor(.lightGrayText)
                }
                Spacer()
            }
            .foregroundStyle(.black)
            .padding(12)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.lightGrayBoarder, lineWidth: 1)
            }
        }
        .frame(height: Constants.searchBarHeight)
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
                        .font(.inter(size: appFontSize.span, weight: .heavy))
                        .tracking(1.2)
                        .foregroundColor(.darkGrayText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Text(Constants.pageTitle)
                        .font(.inter(size: appFontSize.h1, weight: .regular))
                        .foregroundColor(.blackText)
                        .tracking(-1.59)
                        .lineSpacing(0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
                
                Text(userProfile.first?.initials ?? "")
                    .font(.inter(size: appFontSize.button, weight: .heavy))
                    .foregroundColor(.whiteText)
                    .frame(
                        width: Constants.initialViewWidth,
                        height: Constants.initialViewHeight
                    )
                    .background {
                        Circle()
                            .fill(Color.blackBackground)
                    }
                    .padding(.trailing)
            }
        }
        .frame(height: Constants.headerHeight)
        .background(Color.lightBackground)
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
            Text(Constants.emptyViewTitle)
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

