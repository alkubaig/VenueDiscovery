//
//  DiscoverNetwork.swift
//  MyApp
//
//  Created by Ghadeer Alkubaish on 9/16/26.
//

import Foundation
import SwiftUI

class DiscoverNetwork {
    
    /**
     getVenues: fetches venues
     passes a completion handler
     **/
    func getVenues(completion: @escaping ((Venues) -> ())) {
        getVenuesFromFile(completion: completion)
    }
    
    func getVenuesFromApi(completion: @escaping ((Venues) -> ())) {
        // TODO: replace with real api url
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            fatalError("invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let decoder = JSONDecoder()
            
            guard let data else { fatalError("no data") }
            guard let venuesResponse = try? decoder.decode([VenueResponse].self, from: data) else { fatalError("no data or failed to decode \(data)")}
            let venues = venuesResponse.map { self.mapVenueResponseToVenue($0) }
            
            DispatchQueue.main.async {
                completion(venues)
            }
            
        }.resume()
    }
    
    func getVenuesFromFile(completion: @escaping ((Venues) -> ())) {
        // run in background thread
        DispatchQueue.global(qos: .utility).async {
            // read from file for testing
            guard let url = Bundle.main.url(
                forResource: "venues",
                withExtension: "json"
            ) else {
                fatalError("no data or failed to read from json file")
            }
            
            guard let data = try? Data(contentsOf: url) else { fatalError("no data") }
            guard let venuesResponse = try? JSONDecoder().decode([VenueResponse].self, from: data)
                    else {
                fatalError("no data or failed to decode \(data)")
            }
            
            let venues = venuesResponse.map { self.mapVenueResponseToVenue($0) }
            
            DispatchQueue.main.async {
                completion(venues)
            }
        }
    }
    
    func mapVenueResponseToVenue(_ venueResponse: VenueResponse) -> Venue {
        var image: UIImage?
        if let imageURLString = venueResponse.imageURL,
           let imageURL = URL(string: imageURLString),
           let imageData = try? Data(contentsOf: imageURL) {
            image = UIImage(data: imageData)
        }
        
        return Venue(
            id: venueResponse.id,
            title: venueResponse.title,
            body: venueResponse.body,
            image: image,
            rating: venueResponse.rating
        )
    }
}

