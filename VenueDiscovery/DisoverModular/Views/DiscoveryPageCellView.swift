//
//  DiscoverPageCellView.swift
//  MyApp
//
//  Created by Ghadeer Alkubaish on 10/20/26.
//

import SwiftUI

struct DiscoveryPageCellView: View {
    
    var venue: Venue
    
    private enum Constants {
        static let imageHeight: CGFloat = 220
        static let imagCornerRadius: CGFloat = 25
        static let backgroundColor: UIColor = .lightGray
        static let horizontalPadding: CGFloat = 10
        static let verticalPadding: CGFloat = 5
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
    }
    
    @ViewBuilder private func venueInfoView() -> some View {
        let hasImage = venue.image != nil
        VStack(alignment: .leading) {
            Text(venue.body)
                .fontWeight(.regular)
                .foregroundColor(hasImage ? .white : .black)
                .font(.body)
            
            Text(venue.title)
                .foregroundColor(hasImage ? .white : .black)
                .fontWeight(.heavy)
                .font(.title3)
            
            if let rating = venue.rating {
                Text("\(String(rating))")
                    .fontWeight(.bold)
                    .foregroundColor(hasImage ? .white : .black)
                    .font(.body)
            }
        }
        .padding()
    }
    
}

// MARK: preview no iamge and no rating
#Preview {
    let venue = Venue(id: 1, title: "This Venue", body: "Body")
    DiscoveryPageCellView(venue: venue)
}

// MARK: preview no iamge and has rating
#Preview {
    let venue = Venue(id: 1, title: "This Venue", body: "Body", rating: 3)
    DiscoveryPageCellView(venue: venue)
}

// MARK: preview with image
#Preview {
    let venue = Venue(id: 1, title: "This Venue with image", body: "Body", image: UIImage(named: "venue.jpeg"), rating: 3)
    DiscoveryPageCellView(venue: venue)
}



