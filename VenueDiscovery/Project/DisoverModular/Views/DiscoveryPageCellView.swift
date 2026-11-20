//
//  DiscoverPageCellView.swift
//  MyApp
//
//  Created by Ghadeer Alkubaish on 10/20/26.
//

import SwiftUI
import SwiftData

struct DiscoveryPageCellView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteVenues: [FavoriteVenue]
    @Query private var profiles: [UserProfile]

    var venue: Venue
    
    private enum Constants {
        static let imageHeight: CGFloat = 220
        static let imagCornerRadius: CGFloat = 25
        static let backgroundColor: UIColor = .lightGray
        static let horizontalPadding: CGFloat = 10
        static let verticalPadding: CGFloat = 5
        static let inBetweenTextPadding: CGFloat = 2
    }
    
    var isFavorite: Bool {
        favoriteVenues.contains { $0.venueID == venue.id }
    }

    private func toggleFavorite() {
        if let favorite = favoriteVenues.first(where: {
            $0.venueID == venue.id
        }) {
            modelContext.delete(favorite)
        } else {
            guard let user = profiles.first else {
                debugPrint("Failed to update favorite because no user found")
                return
            }
            modelContext.insert(FavoriteVenue(venueID: venue.id, user: user))
        }

        do {
            try modelContext.save()
        } catch {
            debugPrint("Failed to update favorite: \(error)")
        }
    }
    
    var body: some View {
        venuePreviewView()
            .padding(.horizontal, Constants.horizontalPadding)
            .padding(.vertical, Constants.verticalPadding)
    }
    
    @ViewBuilder private func venuePreviewView() -> some View {
        ZStack(alignment: .bottomLeading) {
            if let image = venue.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: Constants.imageHeight)
                    .cornerRadius(Constants.imagCornerRadius)
            }
            
            venueInfoView()
        }
        .overlay(alignment: .topTrailing) {
            Button {
                toggleFavorite()
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(.white)
                    .frame(width: 19, height: 19)
                    .padding(10)
            }
            .buttonStyle(.plain)
            .padding(12)
        }
    }
    
    var cityAndNeighborhood: String {
        return [venue.neighborhood, venue.city]
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .joined(separator: " · ")
    }
    
    @ViewBuilder private func venueInfoView() -> some View {
        let hasImage = venue.image != nil
        VStack(alignment: .leading, spacing: Constants.inBetweenTextPadding) {
            
            Text(cityAndNeighborhood.uppercased())
                .font(.inter(size: 8, weight: .heavy))
                .tracking(1.12)
                .lineLimit(1)
                .truncationMode(.tail)
                .foregroundColor(hasImage ? .white : .black)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(venue.title)
                .tracking(-0.92)
                .foregroundColor(hasImage ? .white : .black)
                .font(.inter(size: 23, weight: .medium))
            
            if let rating = venue.rating {
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")

                    Text(String(format: "%.1f", rating))
                }
                .font(.inter(size: 12, weight: .heavy))
                .foregroundStyle(hasImage ? .white : .black)
            }
        }
        .padding()
    }
}

// MARK: preview

extension DiscoveryPageCellView {
    static var previewWithImage: some View {
        DiscoveryPageCellView(venue: MockVenues.withImage)
    }
    
    static var previewNoImageNoRating: some View {
        DiscoveryPageCellView(venue: MockVenues.noImageNoRating)
    }
    
    static var previewNoImageWithRating: some View {
        DiscoveryPageCellView(venue: MockVenues.noImageWithRating)
    }
}

#Preview("No image, no rating") {
    DiscoveryPageCellView.previewNoImageNoRating
}

#Preview("No image, with rating") {
    DiscoveryPageCellView.previewNoImageWithRating
}

#Preview("With image") {
    DiscoveryPageCellView.previewWithImage

}
