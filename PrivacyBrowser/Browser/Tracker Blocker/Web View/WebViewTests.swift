//
//  WebViewTests.swift
//  PrivacyBrowserTests
//
//  Created by Eray Cetiner on 19.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import OHHTTPStubs
import XCTest
@testable import PrivacyBrowser

final class WebViewTests: TestCase {
    var webView: WebView!
    var mockDelegate: MockWebViewDelegate!

    private let urlWithError = URL(string: "http://localhost:8000/Error.html")
    private let urlWithNoError = URL(string: "http://localhost:8000/NoTrackers.html")
    private let urlWithNoTrackers = URL(string: "http://localhost:8000/NoTrackers.html")
    private let urlWithTwoTrackers = URL(string: "http://localhost:8000/TwoTrackers.html")
    private let urlWithThreeTrackers = URL(string: "http://localhost:8000/ThreeTrackers.html")
    
    private let fakeError = NSError(
        domain: "WebViewTests",
        code: 23,
        userInfo: [:]
    )
    
    override func setUp() {
        super.setUp()
        
        webView = WebView(frame: CGRect(x: 0, y: 0, width: 400, height: 600))
        mockDelegate = MockWebViewDelegate()
        webView.delegate = mockDelegate
    }
    
    override func tearDown() {
        super.tearDown()
        mockDelegate = nil
        webView = nil
    }
    
    func testWhenWebPageIsFailedToLoadThenDelegateIsNotified() {
        let expectation = self.expectation(description: "Web view notifies the delegate after the page is failed to load.")
        mockDelegate.failExpectation = expectation

        webView.load(URLRequest(url: urlWithError!))

        waitForExpectations(timeout: 5) {
            error in
            XCTAssertNil(error)
        }
    }
    
    func testWhenWebPageIsLoadedThenDelegateIsNotified() {
        let expectation = self.expectation(description: "Web view notifies the delegate after the page is loaded.")
        mockDelegate.loadExpectation = expectation
        
        webView.load(URLRequest(url: urlWithNoError!))
        
        waitForExpectations(timeout: 5) {
            error in
            XCTAssertNil(error)
        }
    }
    
    func testWhenWebPageWithNoTrackersIsLoadedThenNoTrackersAreFound() {
        let expectation = self.expectation(description: "Web view does not notify the delegate regarding any detected trackers.")
        mockDelegate.loadExpectation = expectation
        
        webView.load(URLRequest(url: urlWithNoTrackers!))
        
        waitForExpectations(timeout: 5) {
            error in
            XCTAssertNil(error)
            XCTAssertEqual(
                self.mockDelegate.trackers.count,
                0
            )
        }
    }

    func testWhenWebPageWithTwoTrackersIsLoadedThenTwoTrackersAreFound() {
        let expectation = self.expectation(description: "Web view notifies the delegate after all two trackers are detected.")
        mockDelegate.loadExpectation = expectation
        
        webView.load(URLRequest(url: urlWithTwoTrackers!))
        
        waitForExpectations(timeout: 5) {
            error in
            XCTAssertNil(error)
            XCTAssertEqual(
                self.mockDelegate.trackers.count,
                2
            )
        }
    }
    
    func testWhenWebPageWithThreeTrackersIsLoadedThenThreeTrackersAreFound() {
        let expectation = self.expectation(description: "Web view notifies the delegate after all three trackers are detected.")
        mockDelegate.loadExpectation = expectation
        
        webView.load(URLRequest(url: urlWithThreeTrackers!))
        
        waitForExpectations(timeout: 5) {
            error in
            XCTAssertNil(error)
            XCTAssertEqual(
                self.mockDelegate.trackers.count,
                3
            )
        }
    }
}

final class MockWebViewDelegate: WebViewDelegate {
    var failExpectation: XCTestExpectation?
    var loadExpectation: XCTestExpectation?
    var trackers = [Tracker]()
    
    func webView(_ webView: WebView, didFinishLoadingContentAtURL url: URL) {
        loadExpectation?.fulfill()
    }
    
    func webView(_ webView: WebView, didFailLoadingContentWithError error: Error) {
        failExpectation?.fulfill()
    }
    
    func webView(_ webView: WebView, didDetectTracker tracker: Tracker, atURL url: URL) {
        trackers.append(tracker)
    }
}
