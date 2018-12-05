//
//  TestUtil.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 21.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import Foundation

func isRunningUITests() -> Bool {
    return CommandLine.arguments.contains("--uitesting")
}
