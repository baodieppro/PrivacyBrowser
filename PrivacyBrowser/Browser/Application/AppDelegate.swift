//
//  AppDelegate.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 17.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if isRunningUITests() {
            setupForUITests()
        }
        return true
    }
}

extension AppDelegate {
    private func setupForUITests() {
        SuggestionStubs().apply()
    }
}
