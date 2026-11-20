//
//  DiscoveryPageCellView.swift
//  VenueDiscoveryTests
//
//  Created by Ghadeer Alkubaish on 11/19/26.
//

import XCTest
import SwiftUI
import SnapshotTesting
import SwiftData

@testable import VenueDiscovery

final class DiscoveryPageCellViewTests: SnapshotUITest {
    @MainActor
    func testNoImageNoRating() throws {
        try verifySnapshot(
            view: DiscoveryPageCellView.previewNoImageNoRating
        )
    }

    @MainActor
    func testNoImageWithRating() throws {
        try verifySnapshot(
            view: DiscoveryPageCellView.previewNoImageWithRating
        )
    }

    @MainActor
    func testWithImage() throws {
        try verifySnapshot(
            view: DiscoveryPageCellView.previewWithImage
        )
    }
    
}
