//
//  UIColor+HexTests.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 19.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import XCTest
@testable import PrivacyBrowser

final class UIColorHexTests: TestCase {
    func testWhenHexIsGivenThenInitsWithCorrespondingRGB() {
        XCTAssertEqual(
            UIColor(hex: 0x000000),
            UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        )
        
        XCTAssertEqual(
            UIColor(hex: 0xFFFFFF),
            UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        )
        
        XCTAssertEqual(
            UIColor(hex: 0xEDEDED),
            UIColor(red: 237 / 255, green: 237 / 255, blue: 237 / 255, alpha: 1)
        )
    }
}
