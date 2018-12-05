//
//  TrackerDictionaryTests.swift
//  PrivacyBrowserTests
//
//  Created by Eray Cetiner on 19.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import XCTest
@testable import PrivacyBrowser

final class TrackerDictionaryTests: TestCase {
    private var trackerList: TrackerStore!
    private let fakeWebURL1 = URL(string: "http://website1.com")!
    private let fakeWebURL2 = URL(string: "http://website2.com")!
    private let fakeTracker1 = Tracker(url: "http://tracker1.com")
    private let fakeTracker2 = Tracker(url: "http://tracker2.com")
    
    override func setUp() {
        super.setUp()
        trackerList = TrackerDictionary()
    }
    
    override func tearDown() {
        super.tearDown()
        trackerList = nil
    }

    func testWhenEmptyThenShouldRetrieveAnEmptyList() {
        XCTAssertTrue(trackerList.getTrackers(blockedAtURL: fakeWebURL1).isEmpty)
    }

    func testWhenTrackerIsAddedThenShouldRetrieveTrackerList() {
        trackerList.addTracker(fakeTracker1, blockedAtURL: fakeWebURL1)
        trackerList.addTracker(fakeTracker2, blockedAtURL: fakeWebURL1)
        trackerList.addTracker(fakeTracker1, blockedAtURL: fakeWebURL2)
        
        XCTAssertEqual(
            trackerList.getTrackers(blockedAtURL: fakeWebURL1),
            [fakeTracker1, fakeTracker2]
        )
        
        XCTAssertEqual(
            trackerList.getTrackers(blockedAtURL: fakeWebURL2),
            [fakeTracker1]
        )
    }
    
    func testWhenDuplicateTrackerIsAddedThenItShouldBeIgnored() {
        trackerList.addTracker(fakeTracker1, blockedAtURL: fakeWebURL1)
        trackerList.addTracker(fakeTracker1, blockedAtURL: fakeWebURL1)
        trackerList.addTracker(fakeTracker2, blockedAtURL: fakeWebURL1)
        trackerList.addTracker(fakeTracker2, blockedAtURL: fakeWebURL1)
        
        XCTAssertEqual(
            trackerList.getTrackers(blockedAtURL: fakeWebURL1),
            [fakeTracker1, fakeTracker2]
        )
    }
}

