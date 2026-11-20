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
    
    @MainActor
    private func verifySnapshot<Content: View>(
        view: Content,
        file: StaticString = #filePath,
        testName: String = #function
    ) throws {
        let container = try ModelContainer(
            for: FavoriteVenue.self, UserProfile.self,
            configurations: ModelConfiguration(
                isStoredInMemoryOnly: true
            )
        )

        let content = view
            .modelContainer(container)
            .frame(width: 350)

        let controller = UIHostingController(rootView: content)

        assertSnapshot(
            of: controller,
            as: .image(on: .iPhone13),
            file: file,
            testName: testName
        )
    }
}
