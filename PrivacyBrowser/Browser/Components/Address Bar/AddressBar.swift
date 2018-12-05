//
//  AddressBar.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import UIKit

final class AddressBar: UIView {
    @IBOutlet weak private var view: UIView!
    @IBOutlet weak private var trackerCountButton: TrackerCountButton!
    @IBOutlet weak private var addressTextField: UITextField!
    @IBOutlet weak private var reloadButton: UIButton!
    
    var trackerCount: Int? {
        didSet {
            trackerCountButton.trackerCount = trackerCount
        }
    }
    
    var state: AddressBarState? {
        didSet {
            updateUI(forState: state)
        }
    }
    
    weak var delegate: AddressBarDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    @IBAction func addressTextFieldActionTriggered() {
        addressTextField.resignFirstResponder()
        delegate?.addressBar(
            self,
            didSubmitText: addressTextField.text
        )
    }
    
    @IBAction func addressTextFieldEditingDidBegin() {
        state = .typing
    }
    
    @IBAction func addressTextFieldEditingChanged() {
        delegate?.addressBar(
            self,
            didTypeText: addressTextField.text
        )
    }
    
    @IBAction func trackerButtonTapped() {
        delegate?.addressBarDidTapTrackerButton(self)
    }
    
    @IBAction func reloadButtonTapped() {
        delegate?.addressBarDidTapReloadButton(self)
    }
}

// MARK: Custom view init & setup
extension AddressBar {
    private func customInit() {
        loadNib()
        setupAddressTextField()
    }
    
    private func loadNib() {
        Bundle(for: AddressBar.self).loadNibNamed("AddressBar", owner: self, options: nil)
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    private func setupAddressTextField() {
        addressTextField.placeholder = NSLocalizedString(
            "addressbar.textfield.placeholder",
            comment: "TextField placeholder"
        )
    }
}

// MARK: UI states
extension AddressBar {
    private func updateUI(forState state: AddressBarState?) {
        guard let state = state else {
            return
        }
        
        switch state {
        case .idle:
            showIdleState()
        case .pageLoaded(let url):
            showPageLoadedState(withUrl: url)
        case .typing:
            showTypingState()
        }
    }
    
    private func showIdleState() {
        trackerCountButton.isHidden = false
        reloadButton.isHidden = true
        addressTextField.text = ""
    }
    
    private func showPageLoadedState(withUrl url: String) {
        trackerCountButton.isHidden = false
        reloadButton.isHidden = false
        addressTextField.text = url
    }
    
    private func showTypingState() {
        trackerCountButton.isHidden = true
        reloadButton.isHidden = true
    }
}

// MARK: Public methods
extension AddressBar {
    func updateText(with text: String) {
        addressTextField.text = text
    }
}
