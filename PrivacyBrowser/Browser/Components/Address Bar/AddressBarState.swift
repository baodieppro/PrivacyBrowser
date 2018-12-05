//
//  AddressBarState.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

enum AddressBarState {
    case idle
    case pageLoaded(url: String)
    case typing
}
