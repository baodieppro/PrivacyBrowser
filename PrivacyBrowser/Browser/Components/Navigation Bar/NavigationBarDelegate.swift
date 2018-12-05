//
//  NavigationBarDelegate.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

protocol NavigationBarDelegate: AnyObject {
    func navigationBarDidTapBackButton(_ navigationBar: NavigationBar)
    func navigationBarDidTapForwardButton(_ navigationBar: NavigationBar)
}
