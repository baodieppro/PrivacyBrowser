//
//  TrackerCountFormatter.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

struct TrackerCountFormatter: CustomStringConvertible {
    let trackerCount: Int?
    private let maxCountToDisplay = 99
    
    var description: String {
        guard let trackerCount = trackerCount else {
            return "?"
        }
        
        return trackerCount > maxCountToDisplay
            ? "\(maxCountToDisplay)+"
            : "\(trackerCount)"
    }
}
