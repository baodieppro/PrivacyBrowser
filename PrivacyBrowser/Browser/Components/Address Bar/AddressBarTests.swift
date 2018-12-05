//
//  AddressBarTests.swift
//  PrivacyBrowserTests
//
//  Created by Eray Cetiner on 19.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import XCTest
@testable import PrivacyBrowser

final class AddressBarTests: TestCase {
    private var addressBar: AddressBar!
    private var mockDelegate: MockAddressBarDelegate!
    
    override func setUp() {
        super.setUp()
        addressBar = AddressBar(
            frame: CGRect(x: 0, y: 0, width: 400, height: 60)
        )
        mockDelegate = MockAddressBarDelegate()
        addressBar.delegate = mockDelegate
    }
    
    override func tearDown() {
        mockDelegate = nil
        addressBar = nil
    }
    
    func testWhenAddressBarStateIsIdleThenVerifyView() {
        addressBar.state = .idle
        verifyView(addressBar)
    }

    func testWhenAddressBarStateIsTypingThenVerifyView() {
        addressBar.state = .typing
        addressBar.updateText(with: "https://exa")
        verifyView(addressBar)
    }
    
    func testWhenAddressBarStateIsPageLoadedThenVerifyView() {
        addressBar.state = .pageLoaded(url: "https://example.com")
        verifyView(addressBar)
    }
    
    func testWhenTextIsTypedThenDelegateIsNotified() {
        let typedText = "Typed Text"
        addressBar.updateText(with: typedText)
        addressBar.addressTextFieldEditingChanged()
        
        XCTAssertEqual(
            mockDelegate.typedText,
            typedText
        )
    }
    
    func testWhenTextIsSubmittedThenDelegateIsNotified() {
        let submittedText = "Submitted Text"
        addressBar.updateText(with: submittedText)
        addressBar.addressTextFieldActionTriggered()
        
        XCTAssertEqual(
            mockDelegate.submittedText,
            submittedText
        )
    }
    
    func testWhenReloadButtonIsTappedThenDelegateIsNotified() {
        addressBar.reloadButtonTapped()
        XCTAssertTrue(mockDelegate.didTapReloadButton)
    }
    
    func testWhenTrackerButtonIsTappedThenDelegateIsNotified() {
        addressBar.trackerButtonTapped()
        XCTAssertTrue(mockDelegate.didTapTrackerButton)
    }
}

final class MockAddressBarDelegate: AddressBarDelegate {
    var submittedText = ""
    var typedText = ""
    var didTapTrackerButton = false
    var didTapReloadButton = false
    
    func addressBar(_ addressBar: AddressBar, didSubmitText text: String?) {
        submittedText = text ?? ""
    }
    
    func addressBar(_ addressBar: AddressBar, didTypeText text: String?) {
        typedText = text ?? ""
    }
    
    func addressBarDidTapTrackerButton(_ addressBar: AddressBar) {
        didTapTrackerButton = true
    }
    
    func addressBarDidTapReloadButton(_ addressBar: AddressBar) {
        didTapReloadButton = true
    }
}
