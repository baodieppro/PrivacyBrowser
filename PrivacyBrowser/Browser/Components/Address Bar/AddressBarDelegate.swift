//
//  AddressBarDelegate.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

protocol AddressBarDelegate: AnyObject {
    func addressBar(_ addressBar: AddressBar, didSubmitText text: String?)
    func addressBar(_ addressBar: AddressBar, didTypeText text: String?)
    func addressBarDidTapTrackerButton(_ addressBar: AddressBar)
    func addressBarDidTapReloadButton(_ addressBar: AddressBar)
}
