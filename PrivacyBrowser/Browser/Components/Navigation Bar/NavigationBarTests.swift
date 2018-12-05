//
//  NavigationBarTests.swift
//  PrivacyBrowserTests
//
//  Created by Eray Cetiner on 19.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import XCTest
@testable import PrivacyBrowser

final class NavigationBarTests: TestCase {
    private var navigationBar: NavigationBar!
    private var mockDelegate: MockNavigationBarDelegate!
    
    override func setUp() {
        super.setUp()
        navigationBar = NavigationBar(
            frame: CGRect(x: 0, y: 0, width: 400, height: 60)
        )
        mockDelegate = MockNavigationBarDelegate()
        navigationBar.delegate = mockDelegate
    }
    
    override func tearDown() {
        mockDelegate = nil
        navigationBar = nil
    }
    
    func testWhenCantGoBackAndForwardThenVerifyView() {
        navigationBar.navigationState = NavigationState(
            canGoBack: false,
            canGoForward: false
        )
        verifyView(navigationBar)
    }
    
    func testWhenCanGoBackAndCantGoForwardThenVerifyView() {
        navigationBar.navigationState = NavigationState(
            canGoBack: true,
            canGoForward: false
        )
        verifyView(navigationBar)
    }
    
    func testWhenCanGoBackAndForwardThenVerifyView() {
        navigationBar.navigationState = NavigationState(
            canGoBack: true,
            canGoForward: true
        )
        verifyView(navigationBar)
    }
    
    func testWhenBackButtonIsTappedThenDelegateIsNotified() {
        navigationBar.backButtonTapped()
        XCTAssertTrue(mockDelegate.didTapBackButton)
    }
    
    func testWhenForwardButtonIsTappedThenDelegateIsNotified() {
        navigationBar.forwardButtonTapped()
        XCTAssertTrue(mockDelegate.didTapForwardButton)
    }
}

final class MockNavigationBarDelegate: NavigationBarDelegate {
    var didTapBackButton = false
    var didTapForwardButton = false
    
    func navigationBarDidTapBackButton(_ navigationBar: NavigationBar) {
        didTapBackButton = true
    }
    
    func navigationBarDidTapForwardButton(_ navigationBar: NavigationBar) {
        didTapForwardButton = true
    }
}

