//
//  AccountPageView.swift
//  MyApp
//
//  Created by Ghadeer Alkubaish on 10/20/26.
//

import SwiftUI
import SwiftData

struct AccountPageView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var profiles: [UserProfile]
    @Query(sort: \FavoriteVenue.dateAdded, order: .reverse) var favoriteVenues: [FavoriteVenue]

    @State private var firstName = ""
    @State private var lastName = ""
    
    var viewModel = VenuesListViewModel()

    init(viewModel: VenuesListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Personal Information") {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                }
                
                Button("Save Changes") {
                    saveProfile()
                }
                
                Button("Delete me") {
                    deleteProfile()
                }
                
            }
            .onAppear {
                if let profile = profiles.first {
                    firstName = profile.firstName
                    lastName = profile.lastName
                }
            }
            
            if let venues = viewModel.venues {
                FavoriteVenuesCarousel(venues: venues)
            }
        }
    }
    
    private func deleteProfile() {
        guard let profile = profiles.first else {
            debugPrint("No user to delete")
            return
        }
        modelContext.delete(profile)
        firstName = ""
        lastName = ""
    }

    private func saveProfile() {
        if let profile = profiles.first {
            profile.firstName = firstName
            profile.lastName = lastName
        } else {
            let profile = UserProfile(
                firstName: firstName,
                lastName: lastName
            )
            modelContext.insert(profile)
        }

        do {
            try modelContext.save()
        } catch {
            debugPrint("Failed to save profile: \(error)")
        }
    }
}
