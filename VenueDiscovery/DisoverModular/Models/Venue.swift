//
//  Venue.swift
//  MyApp
//
//  Created by Ghadeer Alkubaish on 9/16/26.
//

import Foundation
import SwiftUI

/**
 Venue:
 id: identification
 title: name of the venue
 body: descrption of the venue
 image: optional image of the venue
 rating: optional rating of venue
 location: optional location of venue [coming]
 **/

struct Venue: Hashable, Identifiable {
    let id: Int
    let title: String
    let body: String
    var image: UIImage?
    var rating: Float?
}

typealias Venues = [Venue]
