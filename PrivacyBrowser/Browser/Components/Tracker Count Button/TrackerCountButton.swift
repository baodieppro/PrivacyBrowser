//
//  TrackerCountButton.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import UIKit

final class TrackerCountButton: UIButton {
    var trackerCount: Int? {
        didSet {
            showTrackerCount(trackerCount)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
}

extension TrackerCountButton {
    private func customInit() {
        setupCircleBackground()
    }
    
    private func setupCircleBackground() {
        clipsToBounds = true
        layer.cornerRadius = frame.size.width / 2
        layoutIfNeeded()
    }
    
    private func showTrackerCount(_ count: Int?) {
        setTitle(
            "\(TrackerCountFormatter(trackerCount: trackerCount))",
            for: .normal
        )
    }
}

