//
//  URLFactoryTests.swift
//  PrivacyBrowserTests
//
//  Created by Eray Cetiner on 19.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import XCTest
@testable import PrivacyBrowser

final class URLFactoryTests: TestCase {
    func testWhenURLIsGivenThenReturnsURL() {
        XCTAssertEqual(
            URLFactory.getURL(fromText: "http://duckduckgo.com"),
            URL(string: "http://duckduckgo.com")
        )
        
        XCTAssertEqual(
            URLFactory.getURL(fromText: "https://duckduckgo.com"),
            URL(string: "https://duckduckgo.com")
        )
    }
    
    func testWhenDomainIsGivenThenReturnsURL() {
        XCTAssertEqual(
            URLFactory.getURL(fromText: "duckduckgo.com"),
            URL(string: "http://duckduckgo.com")
        )
    }
    
    func testWhenDomainOrURLIsNotGivenThenReturnsDuckDuckGoSearchURL() {
        XCTAssertEqual(
            URLFactory.getURL(fromText: "example"),
            URL(string: "https://duckduckgo.com/?q=example")
        )
        
        XCTAssertEqual(
            URLFactory.getURL(fromText: "http"),
            URL(string: "https://duckduckgo.com/?q=http")
        )
        
        XCTAssertEqual(
            URLFactory.getURL(fromText: "com"),
            URL(string: "https://duckduckgo.com/?q=com")
        )
    }
}
