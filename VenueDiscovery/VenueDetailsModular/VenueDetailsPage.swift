//
//  VenueDetailsPage.swift
//  VenueDiscovery
//
//  Created by Ghadeer Alkubaish on 10/26/26.
//

import SwiftUI

struct VenueDetailsPage: View {
    
    private enum Constants {
        static let imageHeight: CGFloat = 300
        static let descriptionTitle: String = "About this space"
        static let textPadding: CGFloat = 8
        static let headerHeight: CGFloat = 60
    }
    let venue: Venue
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if let image = venue.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width,
                                   height: Constants.imageHeight)
                            .clipped()
                    } else {
                        Spacer(minLength: Constants.headerHeight)
                    }
                    
                    VStack(alignment: .leading, spacing: Constants.textPadding) {
                        Text(venue.title)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(Constants.descriptionTitle)
                            .font(.title3)
                            .fontWeight(.medium)
                        
                        Text(venue.body)
                            .font(.footnote)
                            .fontWeight(.light)
                    }
                    .padding()
                    
                }
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: preview no iamge
#Preview {
    let venue = Venue(id: 1, title: "This Venue", body: "Body")
    VenueDetailsPage(venue: venue)
}

// MARK: preview with image
#Preview {
    let venue = Venue(id: 1, title: "This Venue with image", body: "Body", image: UIImage(named: "venue.jpeg"), rating: 3)
    VenueDetailsPage(venue: venue)
}



