//
//  SuggestionListTests.swift
//  PrivacyBrowserTests
//
//  Created by Eray Cetiner on 19.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import XCTest
@testable import PrivacyBrowser

final class SuggestionListTests: TestCase {
    private var containerView: UIView!
    private var suggestionList: SuggestionList!
    private var mockDelegate: MockSuggestionListDelegate!
    private let suggestions = [
        Suggestion(phrase: "amazon"),
        Suggestion(phrase: "american airlines"),
        Suggestion(phrase: "american express"),
        Suggestion(phrase: "apple")
    ]
    
    override func setUp() {
        super.setUp()
        containerView = UIView(
            frame: CGRect(x: 0, y: 0, width: 300, height: 200)
        )
        suggestionList = SuggestionList.instanceFromNib()
        containerView.addSubview(suggestionList)
        suggestionList.frame = containerView.bounds

        mockDelegate = MockSuggestionListDelegate()
        suggestionList.delegate = mockDelegate

        suggestionList.suggestions = suggestions
    }
    
    override func tearDown() {
        super.tearDown()
        mockDelegate = nil
        suggestionList = nil
        containerView = nil
    }
    
    func testWhenSuggestionListIsPopulatedThenVerifyView() {
        verifyView(containerView)
    }
    
    func testWhenSuggestionIsSelectedThenDelegateIsNotified() {
        let fakeTableView = UITableView()
        let selectedIndex = 1
        
        suggestionList.tableView(
            fakeTableView,
            didSelectRowAt: IndexPath(row: selectedIndex, section: 0)
        )
        
        XCTAssertEqual(
            mockDelegate.selectedSuggestion!,
            suggestions[selectedIndex]
        )
    }
}

final class MockSuggestionListDelegate: SuggestionListDelegate {
    var selectedSuggestion: Suggestion?
    
    func suggestionList(_ suggestionList: SuggestionList, didTapSuggestion suggestion: Suggestion) {
        selectedSuggestion = suggestion
    }
}
