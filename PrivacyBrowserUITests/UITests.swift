//
//  UITests.swift
//  PrivacyBrowserUITests
//
//  Created by Eray Cetiner on 4.12.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import XCTest

class UITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }
    
    func test() {
        whenAppIsOpenedThenNavigationButtonsShouldBeDisabled()
        whenAppIsOpenedThenReloadButtonShouldBeHidden()
        
        whenTextIsTypedThenSuggestionsShouldBePopulated()
        whenASuggestionIsTappedThenSERPShouldBeDisplayed()
        
        whenAddressIsTypedAndGoButtonIsTappedThenWebPageShouldBeDisplayed()
        whenTrackerButtonIsTappedThenTrackerListPageShouldBeDisplayed()
        
        whenNavigationBackButtonIsTappedThenPreviousPageShouldBeOpened()
    }
    
    private func whenAppIsOpenedThenNavigationButtonsShouldBeDisabled() {
        XCTAssertFalse(app.buttons["navigationBarBackButton"].isEnabled)
        XCTAssertFalse(app.buttons["navigationBarForwardButton"].isEnabled)
    }
    
    private func whenAppIsOpenedThenReloadButtonShouldBeHidden() {
        XCTAssertFalse(app.buttons["addressBarReloadButton"].exists)
    }
    
    private func whenTextIsTypedThenSuggestionsShouldBePopulated() {
        let addressTextField = app.textFields["addressBarAddressTextField"]
        addressTextField.tap()
        addressTextField.typeText("Rick & Morty")
        
        XCTAssertEqual(app.tables.cells.count, 6)
    }
    
    private func whenASuggestionIsTappedThenSERPShouldBeDisplayed() {
        app.tables.staticTexts["rick & morty season 3"].tap()
        
        let existsPredicate = NSPredicate(format: "exists == 1")
        expectation(for: existsPredicate, evaluatedWith: app.staticTexts["A Simple Search Results Page"])
        waitForExpectations(timeout: 5)
        
        let isEnabledPredicate = NSPredicate(format: "isEnabled == 1")
        expectation(for: isEnabledPredicate, evaluatedWith: app.buttons["addressBarReloadButton"])
        waitForExpectations(timeout: 5)
    }
    
    private func whenAddressIsTypedAndGoButtonIsTappedThenWebPageShouldBeDisplayed() {
        let addressTextField = app.textFields["addressBarAddressTextField"]
        addressTextField.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Clear text"]/*[[".textFields[\"Type URL or search\"].buttons[\"Clear text\"]",".textFields[\"addressBarAddressTextField\"].buttons[\"Clear text\"]",".buttons[\"Clear text\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        addressTextField.typeText("http://localhost:8000/NoTrackers.html")
        app.buttons["Go"].tap()
        
        let existsPredicate = NSPredicate(format: "exists == 1")
        expectation(for: existsPredicate, evaluatedWith: app.staticTexts["A Simple Sample Web Page"])
        waitForExpectations(timeout: 5)
    }
    
    private func whenTrackerButtonIsTappedThenTrackerListPageShouldBeDisplayed() {
        app.buttons["addressBarTrackerCountButton"].tap()
        XCTAssertTrue(app.tables.staticTexts.count > 0)
        
        app.navigationBars.buttons["Back"].tap()
    }
    
    private func whenNavigationBackButtonIsTappedThenPreviousPageShouldBeOpened() {
        app.buttons["navigationBarBackButton"].tap()
        
        let isEnabledPredicate = NSPredicate(format: "isEnabled == 1")
        expectation(for: isEnabledPredicate, evaluatedWith: app.buttons["navigationBarForwardButton"])
        waitForExpectations(timeout: 5)
    }
}
