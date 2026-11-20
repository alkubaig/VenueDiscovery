//
//  UserProfile.swift
//  VenueDiscovery
//
//  Created by Ghadeer Alkubaish on 11/18/26.
//

import Foundation
import SwiftData

@Model
class UserProfile {
    @Transient var timeZone = TimeZone.current

    var firstName: String
    var lastName: String
    var fullName: String {
        firstName + " " + lastName
    }
    
    @Relationship(deleteRule: .cascade, inverse: \FavoriteVenue.user)
    var favoriteVenues: [FavoriteVenue] = []
    
    var initials: String {
        let first = firstName.first?.uppercased() ?? ""
        let last = lastName.first?.uppercased() ?? ""

        return first + last
    }

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}
