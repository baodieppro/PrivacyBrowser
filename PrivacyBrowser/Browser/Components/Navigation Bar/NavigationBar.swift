//
//  NavigationBar.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import UIKit

typealias NavigationState = (canGoBack: Bool, canGoForward: Bool)

final class NavigationBar: UIView {
    @IBOutlet weak private var view: UIView!
    @IBOutlet weak private var backButton: UIButton!
    @IBOutlet weak private var forwardButton: UIButton!
    
    var navigationState: NavigationState? {
        didSet{
            updateButtons(forState: navigationState)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    weak var delegate: NavigationBarDelegate?
    
    @IBAction func backButtonTapped() {
        delegate?.navigationBarDidTapBackButton(self)
    }
    
    @IBAction func forwardButtonTapped() {
        delegate?.navigationBarDidTapForwardButton(self)
    }
}

// MARK: Custom view init & setup
extension NavigationBar {
    private func customInit() {
        loadNib()
    }
    
    private func loadNib() {
        Bundle(for: NavigationBar.self).loadNibNamed("NavigationBar", owner: self, options: nil)
        self.addSubview(view)
        view.frame = self.bounds
    }
}

// MARK: UI States
extension NavigationBar {
    private func updateButtons(forState state: NavigationState?) {
        guard let state = state else {
            return
        }
        
        backButton.isEnabled = state.canGoBack
        forwardButton.isEnabled = state.canGoForward
    }
}
