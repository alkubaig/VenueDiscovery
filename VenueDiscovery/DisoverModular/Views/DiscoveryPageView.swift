//
//  DiscoverPageView.swift
//  MyApp
//
//  Created by Ghadeer Alkubaish on 10/20/26.
//

import SwiftUI
import Lottie

struct DiscoveryPageView: View {
    
    enum DiscoverPageConstants {
        static let pageTitle: String =  "Discovery Page"
        static let emptyViewTitle: String =  "EmptyView"
        static let headerHeight: CGFloat = 40
        static let headerSpacer: CGFloat = 1
    }
    
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
    
   // Top header
    @ViewBuilder private func titleView() -> some View {
        VStack() {
            Text(DiscoverPageConstants.pageTitle)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
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
