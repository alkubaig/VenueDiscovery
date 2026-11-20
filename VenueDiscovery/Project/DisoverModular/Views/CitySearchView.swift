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
        "San Francisco",
        "Hillsboro",
        "all"
    ]
    
    private var filteredCities: [String] {
        if searchText.isEmpty {
            return cities
        }
        
        return cities.filter {
            guard searchText.lowercased() != "all" else {
                return true
            }
            return $0.localizedCaseInsensitiveContains(searchText)
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
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            }
            .padding(.horizontal)

            List(filteredCities, id: \.self) { city in
                
                Button {
                        onCitySelected(city == "all" ? "" : city)
                    } label: {
                        HStack {
                            Text(city)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
            }
            .scrollContentBackground(.hidden)
            .background(Color.white)
        }
        .padding(.top)
    }
}
