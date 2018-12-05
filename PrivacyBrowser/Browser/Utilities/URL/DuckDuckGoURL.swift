//
//  DuckDuckGoURL.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

struct DuckDuckGoURL {
    static let base = "https://\(host)"
    static let host = "duckduckgo.com"
    static let suggestionsPath = "/ac"
    static let searchPath = "/"
    
    static let search = "\(base)\(searchPath)?q=%@"
    static let suggestions = "\(base)\(suggestionsPath)?q=%@"
}
