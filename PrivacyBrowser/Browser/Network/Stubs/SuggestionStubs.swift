//
//  SuggestionStubs.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 21.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import OHHTTPStubs

class SuggestionStubs {
    private let headers = ["Content-Type": "application/json"]

    func apply() {
        stub(condition: isHost(DuckDuckGoURL.host) && isPath(DuckDuckGoURL.suggestionsPath)) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("FakeSuggestions.json", type(of: self))!,
                statusCode: 200,
                headers: self.headers
            )
        }
    }
}
