//
//  DuckDuckGoSearchURLTests.swift
//  PrivacyBrowserTests
//
//  Created by Eray Cetiner on 19.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import XCTest
@testable import PrivacyBrowser

final class DuckDuckGoSearchURLTests: TestCase {
    func testWhenSearchIsGivenThenReturnsDuckDuckGoSearchURL() {
        XCTAssertEqual(
            DuckDuckGoSearchURL(search: "rick & morty").getURL(),
            URL(string: "https://duckduckgo.com/?q=rick%20%26%20morty")
        )
    }
}
