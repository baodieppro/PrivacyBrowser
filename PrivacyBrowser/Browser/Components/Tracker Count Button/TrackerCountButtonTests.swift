//
//  TrackerCountButtonTests.swift
//  PrivacyBrowserTests
//
//  Created by Eray Cetiner on 19.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import XCTest
@testable import PrivacyBrowser

final class TrackerCountButtonTests: TestCase {
    private var trackerCountButton: TrackerCountButton!
    
    override func setUp() {
        super.setUp()
        trackerCountButton = TrackerCountButton(
            frame: CGRect(x: 0, y: 0, width: 40, height: 40)
        )
        trackerCountButton.backgroundColor = Color.Grey.dark
    }
    
    override func tearDown() {
        super.tearDown()
        trackerCountButton = nil
    }
    
    func testWhenTrackerButtonIsInitializedThenVerifyView() {
        trackerCountButton.trackerCount = 17
        verifyView(trackerCountButton)
    }
}
