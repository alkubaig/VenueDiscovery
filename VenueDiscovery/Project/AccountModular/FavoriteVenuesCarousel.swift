//
//  FavoriteVenuesCarousel.swift
//  VenueDiscovery
//
//  Created by Ghadeer Alkubaish on 11/19/26.
//

import SwiftUI
import SwiftData

struct FavoriteVenuesCarousel: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \FavoriteVenue.dateAdded, order: .reverse) var favoriteVenues: [FavoriteVenue]
    let venues: Venues
    
    init(venues: Venues) {
        self.venues = venues
    }

    private var savedVenues: [Venue] {
        favoriteVenues.compactMap { favorite in
           venues.first {
                $0.id == favorite.venueID
            }
        }
    }

    var body: some View {
        if !savedVenues.isEmpty {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Favotite venues")
                        .font(.inter(size: 24, weight: .medium))
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: 16) {
                        ForEach(savedVenues) { venue in
                            NavigationLink {
                                VenueDetailsPage(venue: venue)
                            } label: {
                                FavoriteVenueCard(venue: venue)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
