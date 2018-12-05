//
//  ScriptUtil.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 19.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import Foundation

struct ScriptUtil {
    static let scriptWithVariableFormat = "let %@ = \"%@\";"
    
    static func scriptContent(fromFile fileName: String,
                              withType fileType: String) -> String {
        guard let scriptURL = Bundle.main.path(forResource: fileName, ofType: fileType) else {
            return ""
        }
        
        do {
            return try String(
                contentsOfFile: scriptURL,
                encoding: String.Encoding.utf8
            )
        } catch{
            return ""
        }
    }
    
    static func scriptContent(withVariable variableName: String,
                              withVariableContentFromFile fileName: String,
                              withType fileType: String) -> String {
        let content = FileUtil(name: fileName, type: fileType).read()
        let escapedContent = escape(variableContent: content)
        let script = String(
            format: scriptWithVariableFormat,
            variableName,
            escapedContent
        )
        
        return script
    }
    
    static func escape(variableContent content: String) -> String {
        return content.replacingOccurrences(of: "\n", with: "\\n")
            .replacingOccurrences(of: "\\\"", with: "\"")
            .replacingOccurrences(of: "\"", with: "\\\"")
    }
}
