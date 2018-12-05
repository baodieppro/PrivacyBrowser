//
//  TrackerDictionary.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import Foundation

final class TrackerDictionary: TrackerStore {
    private var trackerList = [URL:[Tracker]]()
    
    func addTracker(_ tracker: Tracker, blockedAtURL url: URL) {
        if trackerList.keys.contains(url) {
            if !trackerList[url]!.contains(tracker) {
                trackerList[url]!.append(tracker)
            }
        } else {
            trackerList[url] = [tracker]
        }
    }
    
    func getTrackers(blockedAtURL url: URL) -> [Tracker] {
        return trackerList[url] ?? [Tracker]()
    }
}
