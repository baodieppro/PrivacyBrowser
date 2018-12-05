//
//  URLUtilTests.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 19.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import XCTest
@testable import PrivacyBrowser

final class URLUtilTests: XCTestCase {
    func testWhenTextIsGivenThenReturnsURLEncodedText() {
        XCTAssertEqual(
            URLUtil.urlEncode(text: "mailto:email?subject=testing this & that @%"),
            "mailto%3Aemail%3Fsubject%3Dtesting%20this%20%26%20that%20%40%25"
        )
    }
    
    func testWhenURLIsGivenThenReturnsTrue() {
        XCTAssertTrue(
            URLUtil.isURL(text: "http://duckduckgo.com")
        )
        
        XCTAssertTrue(
            URLUtil.isURL(text: "https://duckduckgo.com")
        )
    }
    
    func testWhenURLIsNotGivenThenReturnsFalse() {
        XCTAssertFalse(
            URLUtil.isURL(text: "duckduckgo")
        )
        
        XCTAssertFalse(
            URLUtil.isURL(text: "duckduckgo.com")
        )
    }
}
