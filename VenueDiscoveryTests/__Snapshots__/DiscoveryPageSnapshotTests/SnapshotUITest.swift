//
//  SnapshotUITest.swift
//  VenueDiscovery
//
//  Created by Ghadeer Alkubaish on 11/19/26.
//

import XCTest
import SwiftUI
import SnapshotTesting
import SwiftData

@testable import VenueDiscovery

/**
 parent class for ui tests
 **/
class SnapshotUITest: XCTestCase {
    @MainActor
    func verifySnapshot<Content: View>(
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
