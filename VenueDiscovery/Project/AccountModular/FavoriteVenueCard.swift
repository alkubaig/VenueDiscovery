//
//  FavoriteVenueCard.swift
//  VenueDiscovery
//
//  Created by Ghadeer Alkubaish on 11/19/26.
//

import SwiftUI

struct FavoriteVenueCard: View {
    let venue: Venue

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let image = venue.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 220, height: 140)
                    .clipped()
                    .clipShape(
                        RoundedRectangle(cornerRadius: 16)
                    )
            }

            Text(venue.title)
                .font(.inter(size: 18, weight: .regular))
                .lineLimit(1)

            if let rating = venue.rating {
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")

                    Text(String(format: "%.1f", rating))
                }
                .font(.inter(size: 13))
                .foregroundStyle(.gray)
            }
        }
        .frame(width: 220, alignment: .leading)
    }
}
