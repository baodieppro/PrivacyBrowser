//
//  DuckDuckGoSearchURL.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import Foundation

struct DuckDuckGoSearchURL {
    let search: String
    
    func getURL() -> URL? {
        return URL(
            string: String(
                format: DuckDuckGoURL.search,
                URLUtil.urlEncode(text: search)
            )
        )
    }
}
