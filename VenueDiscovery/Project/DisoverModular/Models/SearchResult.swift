//
//  SearchResult.swift
//  VenueDiscovery
//
//  Created by Ghadeer Alkubaish on 11/18/26.
//

import Foundation
import SwiftData

@Model
class SearchResult {
    var userSelectedCity: String
    
    init(city: String) {
        self.userSelectedCity = city
    }
}

