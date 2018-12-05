//
//  TrackerStorage.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import Foundation

protocol TrackerStore {
    func addTracker(_ tracker: Tracker, blockedAtURL url: URL)
    func getTrackers(blockedAtURL url: URL) -> [Tracker]
}
