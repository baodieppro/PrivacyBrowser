//
//  URLUtil.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import Foundation
import WebKit

struct URLUtil {
    static func urlEncode(text: String) -> String {
        var allowedQueryParamAndKey = NSCharacterSet.urlQueryAllowed
        allowedQueryParamAndKey.remove(charactersIn: ";/?:@&=+$, ")
        return text.addingPercentEncoding(withAllowedCharacters: allowedQueryParamAndKey) ?? text
    }
    
    static func isURL(text: String) -> Bool {
        // See http://urlregex.com/
        let urlPattern = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"

        if let regex = try? NSRegularExpression(pattern: urlPattern) {
            let range = NSRange(location: 0, length: text.utf16.count)
            return regex.firstMatch(in: text, options: [], range: range) != nil
        }

        return false
    }
}
