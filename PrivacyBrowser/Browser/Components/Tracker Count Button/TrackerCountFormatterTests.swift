//
//  TrackerCountFormatterTests.swift
//  PrivacyBrowserTests
//
//  Created by Eray Cetiner on 19.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import XCTest
@testable import PrivacyBrowser

final class TrackerCountFormatterTests: TestCase {
    func testWhenCountIsNilThenReturnsQuestionMark() {
        XCTAssertEqual(
            TrackerCountFormatter(trackerCount: nil).description,
            "?"
        )
    }
    
    func testWhenCountIsLessThanMaxToDisplayThenReturnsCount() {
        XCTAssertEqual(
            TrackerCountFormatter(trackerCount: 0).description,
            "0"
        )
        
        XCTAssertEqual(
            TrackerCountFormatter(trackerCount: 1).description,
            "1"
        )
        
        XCTAssertEqual(
            TrackerCountFormatter(trackerCount: 2).description,
            "2"
        )
    }
    
    func testWhenCountIsHigherThanMaxToDisplayThenReturnsMaxToDisplay() {
        XCTAssertEqual(
            TrackerCountFormatter(trackerCount: 999).description,
            "99+"
        )
    }
}
