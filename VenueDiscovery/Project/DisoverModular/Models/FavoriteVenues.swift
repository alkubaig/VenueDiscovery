//
//  FavoriteVenues.swift
//  VenueDiscovery
//
//  Created by Ghadeer Alkubaish on 11/19/26.
//


import SwiftData

@Model
final class FavoriteVenues {
    @Attribute(.unique) var venueID: Int

    init(venueID: Int) {
        self.venueID = venueID
    }
}
