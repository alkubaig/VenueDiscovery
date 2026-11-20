//
//  FavoriteVenues.swift
//  VenueDiscovery
//
//  Created by Ghadeer Alkubaish on 11/19/26.
//


import SwiftData
import Foundation

@Model
class FavoriteVenue {
    @Attribute(.unique) var venueID: Int
    var user: UserProfile?

    init(venueID: Int, user: UserProfile) {
        self.venueID = venueID
        self.user = user
    }
}
