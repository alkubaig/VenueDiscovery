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

final class DiscoveryPageSnapshotTests: SnapshotUITest {
    @MainActor
    func testEmptyDiscoveryPage() throws {
        try verifySnapshot(
            view: DiscoveryPageView.emptyPreview
        )
    }

    @MainActor
    func testDiscoveryPage() throws {
        try verifySnapshot(
            view: DiscoveryPageView.nonEmptyPreview
        )
    }
    

}

