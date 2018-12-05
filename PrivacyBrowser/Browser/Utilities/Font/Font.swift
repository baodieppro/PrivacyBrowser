//
//  Font.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import UIKit

enum Font: String {
    case lineAwesome = "LineAwesome"
    case sourceSansProRegular = "SourceSansPro-Regular"
    case sourceSansProSemibold = "SourceSansPro-Semibold"
    
    func getWithSize(_ size: Double) -> UIFont {
        return UIFont(name: self.rawValue, size: CGFloat(size))!
    }
}
