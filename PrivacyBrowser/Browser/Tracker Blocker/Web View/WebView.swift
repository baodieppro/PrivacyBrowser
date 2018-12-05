//
//  WebView.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import WebKit

final class WebView: WKWebView {
    weak var delegate: WebViewDelegate?
    
    convenience init(frame: CGRect) {
        self.init(
            frame: frame,
            configuration: WebViewConfiguration()
        )
        customInit()
    }
}

// MARK: Setup
extension WebView {
    private func customInit() {
        setupDelegates()
        setupScriptMessageHandler()
    }
    
    private func setupDelegates() {
        self.uiDelegate = self
        self.navigationDelegate = self
    }
    
    private func setupScriptMessageHandler() {
        for scriptMessage in ScriptMessage.allCases {
            configuration.userContentController.add(
                self,
                name: scriptMessage.rawValue
            )
        }
    }
}

// MARK: WKNavigation delegate
extension WebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let url = url else {
            return
        }

        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        delegate?.webView(
            self,
            didFinishLoadingContentAtURL: url
        )
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        delegate?.webView(
            self,
            didFailLoadingContentWithError: error
        )
    }
}

// MARK: WKUIDelegate
extension WebView: WKUIDelegate {
    // See: https://stackoverflow.com/questions/25713069/why-is-wkwebview-not-opening-links-with-target-blank
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        return nil
    }
}

// MARK: WKScriptMessage handler
extension WebView: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let scriptMessage = ScriptMessage(rawValue: message.name) else {
            return
        }
        
        switch scriptMessage {
        case .trackerDetected:
            if let trackerUrl = message.body as? String, let webpageUrl = url {
                delegate?.webView(
                    self,
                    didDetectTracker: Tracker(url: trackerUrl),
                    atURL: webpageUrl
                )
            }
        }
    }
}
