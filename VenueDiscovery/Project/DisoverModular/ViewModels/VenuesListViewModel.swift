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
        debugPrint("Fonts")
        for family in UIFont.familyNames {
            if family.lowercased().contains("inter") {
                print("Family:", family)
                print("Fonts:", UIFont.fontNames(forFamilyName: family))
            }
        }
        fetchVenues()
    }
    
    func fetchVenues() {
        debugPrint("fetchPosts")
        DiscoverNetwork().getVenues {
            debugPrint("fetchPosts success \($0)")
            self.venues = $0
            self.isDoneFetching = true
        }
    }
}
