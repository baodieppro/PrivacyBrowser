//
//  TrackerListTableViewController.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import UIKit

final class TrackerListTableViewController: UITableViewController {
    @IBOutlet weak private var navigationBar: UINavigationItem!
    @IBOutlet weak private var backButton: UIBarButtonItem!

    private let reuseIdentifier = "trackerListTableViewCell"
    
    var trackers: [Tracker]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackers?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.text = trackers?[indexPath.row].url
        return cell
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: Navigation bar
extension TrackerListTableViewController {
    private func setupNavigationBar() {
        backButton.title = NSLocalizedString("Back", comment: "Back")
        navigationBar.title = String(
            format: NSLocalizedString("trackerlist.title", comment: "Title"),
            trackers?.count ?? 0
        )
    }
}
