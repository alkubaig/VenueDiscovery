//
//  VenuesListViewModel.swift
//  MyApp
//
//  Created by Ghadeer Alkubaish on 9/16/26.
//

import Foundation
import SwiftUI
import Combine

class VenuesListViewModel: ObservableObject {
    @Published var venues: Venues?
    @Published var isDoneFetching: Bool = false
    
    init() {
        fetchVenues()
    }
    
    func fetchVenues() {
        print("fetchPosts")
        DiscoverNetwork().getVenues {
            debugPrint("fetchPosts success \($0)")
            self.venues = $0
            self.isDoneFetching = true
        }
    }
}
