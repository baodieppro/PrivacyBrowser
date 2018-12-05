//
//  WebViewConfiguration.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 19.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import WebKit

final class WebViewConfiguration: WKWebViewConfiguration {
    private let scripts: [Script] = [
        .easyList,
        .easyListPrivacy,
        .badFingerPrints,
        .bloomFilter,
        .abpFilterParser,
        .trackerBlocker
    ]

    override init() {
        super.init()
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
}

extension WebViewConfiguration {
    private func customInit() {
        setupPreferences()
        setupContentController()
        injectScripts(to: userContentController)
    }
    
    private func setupPreferences() {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        self.preferences = preferences
    }
    
    private func setupContentController() {
        self.userContentController = WKUserContentController()
    }
    
    private func injectScripts(to userContentController: WKUserContentController) {
        for script in scripts {
            userContentController.addUserScript(script.getScript())
        }
    }
}
