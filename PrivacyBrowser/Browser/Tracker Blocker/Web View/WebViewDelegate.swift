//
//  WebViewDelegate.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import Foundation

protocol WebViewDelegate: AnyObject {
    func webView(_ webView: WebView, didFinishLoadingContentAtURL url: URL)
    func webView(_ webView: WebView, didFailLoadingContentWithError error: Error)
    func webView(_ webView: WebView, didDetectTracker tracker: Tracker, atURL url: URL)
}
