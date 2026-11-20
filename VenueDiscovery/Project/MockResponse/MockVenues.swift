//
//  MockVenues.swift
//  VenueDiscovery
//
//  Created by Ghadeer Alkubaish on 11/19/26.
//

import Foundation
import SwiftUI

enum MockVenues {
    static let noImageNoRating = Venue(
        id: 1,
        title: "This Venue",
        body: "Body",
        city: "Hillsboro",
        neighborhood: "Reeds-crossing"
    )

    static let noImageWithRating = Venue(
        id: 2,
        title: "This Venue",
        body: "Body",
        rating: 3,
        city: "Portland"
    )

    static let withImage = Venue(
        id: 3,
        title: "This Venue with image",
        body: "Body",
        image: UIImage(named: "venue.jpeg"),
        rating: 3,
        city: "New york",
        neighborhood: "SOHO"
    )
}
