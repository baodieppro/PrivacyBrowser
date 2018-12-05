//
//  FileUtil.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import Foundation

struct FileUtil {
    let name: String
    let type: String
    
    func read() -> String {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                return try NSString.init(
                    contentsOfFile: path,
                    encoding: String.Encoding.utf8.rawValue
                    ) as String
            } catch {}
        }
        
        return ""
    }
}
