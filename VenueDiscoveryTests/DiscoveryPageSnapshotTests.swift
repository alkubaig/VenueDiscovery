//
//  DiscoveryPageSnapshotTests.swift
//  VenueDiscovery
//
//  Created by Ghadeer Alkubaish on 11/19/26.
//

import XCTest
import SwiftUI
import SnapshotTesting
import SwiftData
@testable import VenueDiscovery

final class DiscoveryPageSnapshotTests: XCTestCase {

    @MainActor
    func testNoImageNoRating() throws {
        try verifySnapshot(
            venue: MockVenues.noImageNoRating
        )
    }

    @MainActor
    func testNoImageWithRating() throws {
        try verifySnapshot(
            venue: MockVenues.noImageWithRating
        )
    }

    @MainActor
    func testWithImage() throws {
        try verifySnapshot(
            venue: MockVenues.withImage
        )
    }

    @MainActor
    private func verifySnapshot(
        venue: Venue,
        file: StaticString = #filePath,
        testName: String = #function
    ) throws {
        let container = try ModelContainer(
            for: FavoriteVenue.self, UserProfile.self,
            configurations: ModelConfiguration(
                isStoredInMemoryOnly: true
            )
        )

        let view = DiscoveryPageCellView(venue: venue)
            .modelContainer(container)
            .frame(width: 350)

        let controller = UIHostingController(rootView: view)

        assertSnapshot(
            of: controller,
            as: .image(on: .iPhone13),
            file: file,
            testName: testName
        )
    }
}
