//
//  VenueDetailsPageTests.swift
//  VenueDiscovery
//
//  Created by Ghadeer Alkubaish on 11/19/26.
//

import XCTest
import SwiftUI
import SnapshotTesting
import SwiftData

@testable import VenueDiscovery

final class VenueDetailsPageTests: SnapshotUITest {
    @MainActor
    func testVenueDetailsNoImageNoRating() throws {
        try verifySnapshot(
            view: VenueDetailsPage.previewNoImageNoRating
        )
    }

    @MainActor
    func testVenueDetailsNoImageWithRating() throws {
        try verifySnapshot(
            view: VenueDetailsPage.previewNoImageWithRating
        )
    }

    @MainActor
    func testVenueDetailsWithImage() throws {
        try verifySnapshot(
            view: VenueDetailsPage.previewWithImage
        )
    }
    
}
