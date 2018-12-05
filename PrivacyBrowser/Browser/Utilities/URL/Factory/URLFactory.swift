//
//  URLFactory.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import Foundation

struct URLFactory {
    static let httpPrefix = "http://"
    static let httpsPrefix = "https://"
    
    static func getURL(fromText text: String) -> URL? {
        if URLUtil.isURL(text: text) {
            return URL(string: text)
        } else if !text.starts(with: httpPrefix)
            && !text.starts(with: httpsPrefix)
            && URLUtil.isURL(text: "\(httpPrefix)\(text)") {
            return URL(string: "\(httpPrefix)\(text)")
        } else {
            return DuckDuckGoSearchURL(search: text).getURL()
        }
    }
}
