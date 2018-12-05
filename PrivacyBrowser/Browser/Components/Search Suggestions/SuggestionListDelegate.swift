//
//  SuggestionListDelegate.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 19.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

protocol SuggestionListDelegate: AnyObject {
    func suggestionList(_ suggestionList: SuggestionList, didTapSuggestion suggestion: Suggestion)
}
