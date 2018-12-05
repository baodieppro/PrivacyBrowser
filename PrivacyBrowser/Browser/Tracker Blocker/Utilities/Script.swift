//
//  Script.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 19.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import WebKit

enum Script {
    case abpFilterParser
    case badFingerPrints
    case bloomFilter
    case easyList
    case easyListPrivacy
    case trackerBlocker
    
    public func getScript() -> WKUserScript {
        return WKUserScript(
            source: getScriptContent(),
            injectionTime: .atDocumentStart,
            forMainFrameOnly: true
        )
    }
    
    private func getScriptContent() -> String {
        switch self {
        case .abpFilterParser:
            return ScriptUtil.scriptContent(
                fromFile: "ABPFilterParserGlobal",
                withType: "js"
            )
        case .badFingerPrints:
            return ScriptUtil.scriptContent(
                fromFile: "BadFingerPrintsGlobal",
                withType: "js"
            )
        case .bloomFilter:
            return ScriptUtil.scriptContent(
                fromFile: "BloomFilterGlobal",
                withType: "js"
            )
        case .easyList:
            return ScriptUtil.scriptContent(
                withVariable: "easyListTxt",
                withVariableContentFromFile: "easylist",
                withType: "txt"
            )
        case .easyListPrivacy:
            return ScriptUtil.scriptContent(
                withVariable: "easyListPrivacyTxt",
                withVariableContentFromFile: "easyprivacy",
                withType: "txt"
            )
        case .trackerBlocker:
            return ScriptUtil.scriptContent(
                fromFile: "TrackerBlocker",
                withType: "js"
            )
        }
    }
}
