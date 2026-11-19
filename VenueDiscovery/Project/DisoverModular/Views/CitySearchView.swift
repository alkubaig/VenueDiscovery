//
//  CitySearch.swift
//  VenueDiscovery
//
//  Created by Ghadeer Alkubaish on 11/18/26.
//

import SwiftUI

struct CitySearchView: View {
    @State private var searchText = ""
    var onCitySelected: (String) -> Void
    
    private let cities = [
        "Portland",
        "Seattle",
        "San Francisco"
    ]
    
    private var filteredCities: [String] {
        if searchText.isEmpty {
            return cities
        }
        
        return cities.filter {
            $0.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)

                TextField("Search cities", text: $searchText)
                    .autocorrectionDisabled()
            }
            .padding(10)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)

            List(filteredCities, id: \.self) { city in
                Text(city)
                    .onTapGesture {
                        onCitySelected(city)
                    }
            }
        }
        .padding(.top)
    }
}
