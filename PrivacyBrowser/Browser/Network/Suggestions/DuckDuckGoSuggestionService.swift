//
//  DuckDuckGoSuggestionService.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import Foundation

struct DuckDuckGoSuggestionService: SuggestionService {
    func getSuggestions(
        forText text: String,
        completionHandler: GetSuggestionsCompletionHandler?,
        errorHandler: GetSuggestionsErrorHandler?) {
        
        let suggestionsUrlString = String(
            format: DuckDuckGoURL.suggestions,
            URLUtil.urlEncode(text: text)
        )
        
        let suggestionsUrl = URL(string: suggestionsUrlString)
        
        let task = URLSession.shared.dataTask(with: suggestionsUrl!) {
            (data, response, error) in
            
            guard error == nil else {
                errorHandler?(error)
                return
            }
            
            guard let content = data else {
                errorHandler?(nil)
                return
            }
            
            guard let suggestions = try? JSONDecoder().decode([Suggestion].self, from: content) else {
                errorHandler?(nil)
                return
            }
            
            completionHandler?(suggestions)
        }
        task.resume()
    }
}
