//
//  Color.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import UIKit

enum Color {
    enum Grey {
        static let lightest = UIColor(hex: 0xEDEDED)
        static let dark = UIColor(hex: 0x666667)
    }
    
    enum NavigationButton {
        static let disabledColor = Color.Grey.lightest
        static let enabledColor = Color.Grey.dark
    }
}
