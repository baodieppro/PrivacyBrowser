//
//  SuggestionService.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import Foundation

typealias GetSuggestionsCompletionHandler = ([Suggestion]) -> Void
typealias GetSuggestionsErrorHandler = (Error?) -> Void

protocol SuggestionService {
    func getSuggestions(
        forText text: String,
        completionHandler: GetSuggestionsCompletionHandler?,
        errorHandler: GetSuggestionsErrorHandler?
    )
}
