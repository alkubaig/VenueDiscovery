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

    @State private var firstName = ""
    @State private var lastName = ""

    var body: some View {
        Form {
            Section("Personal Information") {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
            }

            Button("Save Changes") {
                saveProfile()
            }
        }
        .onAppear {
            if let profile = profiles.first {
                firstName = profile.firstName
                lastName = profile.lastName
            }
        }
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
